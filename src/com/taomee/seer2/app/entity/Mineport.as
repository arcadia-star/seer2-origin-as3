package com.taomee.seer2.app.entity {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.core.cookie.SharedObjectManager;
import com.taomee.seer2.core.entity.AnimateElement;
import com.taomee.seer2.core.entity.IExtendedEntity;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;
import com.taomee.seer2.core.utils.Util;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.net.SharedObject;

public class Mineport extends AnimateElement implements IExtendedEntity {


    private var _actorPosition:Point;

    private var _limit:int;

    private var _serverConfigId:uint;

    private var _mineAnimation:MovieClip;

    private var _parser:Parser_1060;

    public function Mineport() {
        super();
    }

    private function onDigError(param1:uint):void {
        LayerManager.resetOperation();
        this.showUnavaliableMessage();
    }

    public function setData(param1:XML):void {
        var _loc4_:Point = null;
        var _loc2_:String = param1.attribute("resId").toString();
        this.resourceUrl = URLUtil.getMapMineSwf(_loc2_);
        this.name = param1.attribute("name").toString();
        TooltipManager.addCommonTip(this, this.name);
        var _loc3_:String = param1.attribute("pos").toString();
        _loc4_ = Util.parsePositionStr(_loc3_);
        this.x = _loc4_.x;
        this.y = _loc4_.y;
        var _loc5_:String = param1.attribute("actorPos").toString();
        this._actorPosition = Util.parsePositionStr(_loc5_);
        this._limit = uint(param1.attribute("limit").toString());
        this._serverConfigId = uint(param1.attribute("serverConfigId").toString());
        this.addPortClickEventListener();
    }

    private function addPortClickEventListener():void {
        this.buttonMode = true;
        addEventListener(MouseEvent.CLICK, this.onPortClick);
    }

    private function onPortClick(param1:MouseEvent):void {
        var _loc2_:int = this.getAvailableDigTime();
        if (_loc2_ <= 0) {
            this.showUnavaliableMessage();
            return;
        }
        var _loc3_:Actor = ActorManager.getActor();
        var _loc4_:Boolean;
        if (_loc4_ = Boolean(_loc3_.isArrivedPosition(this._actorPosition))) {
            this.askMine();
        } else {
            _loc3_.addEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
            _loc3_.runToLocation(this._actorPosition.x, this._actorPosition.y);
        }
        param1.stopImmediatePropagation();
    }

    private function onActorMoveFinished(param1:MoveEvent):void {
        var _loc2_:Actor = ActorManager.getActor();
        _loc2_.removeEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
        var _loc3_:Boolean = Boolean(_loc2_.isArrivedPosition(this._actorPosition));
        if (_loc3_ == true) {
            this.askMine();
        }
    }

    private function onEnter(param1:Event):void {
        var evt:Event = param1;
        if (this._mineAnimation.currentFrame == this._mineAnimation.totalFrames) {
            this._mineAnimation.removeEventListener(Event.ENTER_FRAME, this.onEnter);
            LayerManager.resetOperation();
            this._mineAnimation.stop();
            DisplayObjectUtil.removeFromParent(this._mineAnimation);
            InteractiveRewardManager.requestReward(this._serverConfigId, function (param1:Parser_1060):void {
                param1.showResult();
                addDiggedNum();
                ItemManager.dispatchEvent(ItemEvent.MINE_SUCCESS, _serverConfigId);
            }, this.onDigError);
        }
    }

    private function abortMineAnimation():void {
        this._mineAnimation.removeEventListener(Event.ENTER_FRAME, this.onEnter);
        this._mineAnimation.gotoAndStop(this._mineAnimation.totalFrames);
    }

    private function askMine():void {
        if (!this._mineAnimation) {
            this._mineAnimation = UIManager.getMovieClip("UI_mineAnimation");
            this._mineAnimation.gotoAndStop(this._mineAnimation.totalFrames);
        }
        this._mineAnimation.gotoAndPlay(1);
        this._mineAnimation.addEventListener(Event.ENTER_FRAME, this.onEnter);
        addChild(this._mineAnimation);
        if (ShootController.isAim == true) {
            ShootController.close();
        }
        LayerManager.focusOnTopLayer();
    }

    private function onDiggerMine(param1:Parser_1060):void {
        this._parser = param1;
    }

    private function getAvailableDigTime():int {
        var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.DIGGING);
        var _loc2_:String = this.generateDateKey();
        var _loc3_:String = this.generateMineKey();
        if (_loc1_.data[_loc2_] == null) {
            this.resetSharedObject(_loc1_, _loc2_);
        }
        var _loc4_:Object;
        if ((_loc4_ = _loc1_.data[_loc2_][_loc3_]) == null) {
            (_loc4_ = new Object()).diggedNum = 0;
            _loc1_.data[_loc2_][_loc3_] = _loc4_;
            SharedObjectManager.flush(_loc1_);
        }
        return this._limit - _loc4_.diggedNum;
    }

    private function addDiggedNum():void {
        var _loc4_:Object = null;
        var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.DIGGING);
        var _loc2_:String = this.generateDateKey();
        var _loc3_:String = this.generateMineKey();
        if (_loc2_ in _loc1_.data) {
            ++(_loc4_ = _loc1_.data[_loc2_][_loc3_]).diggedNum;
        } else {
            (_loc4_ = new Object()).diggedNum = 1;
            _loc1_.data[_loc2_][_loc3_] = _loc4_;
        }
        SharedObjectManager.flush(_loc1_);
        this.updatePortInteraction();
    }

    private function updatePortInteraction():void {
        var _loc1_:int = this.getAvailableDigTime();
        if (_loc1_ <= 0) {
            this.showUnavaliableMessage();
        }
    }

    private function showUnavaliableMessage():void {
        ServerMessager.addMessage("矿石需要合理开发明天再来采集吧");
    }

    private function resetSharedObject(param1:SharedObject, param2:String):void {
        param1.clear();
        param1.data[param2] = new Object();
        param1.flush();
    }

    private function generateDateKey():String {
        var _loc1_:Date = new Date();
        return Connection.netType.toString() + _loc1_.fullYear + "_" + _loc1_.month + "_" + _loc1_.date;
    }

    private function generateMineKey():String {
        return SceneManager.active.mapID.toString() + "_" + this.id;
    }

    override public function dispose():void {
        this._parser = null;
        TooltipManager.remove(this);
        ActorManager.getActor().removeEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
        if (this._mineAnimation != null) {
            this.abortMineAnimation();
            this._mineAnimation = null;
        }
        removeEventListener(MouseEvent.CLICK, this.onPortClick);
        super.dispose();
    }
}
}
