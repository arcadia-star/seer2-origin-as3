package com.taomee.seer2.app.entity {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.entity.pool.TeleportResourcePool;
import com.taomee.seer2.core.entity.AnimateElement;
import com.taomee.seer2.core.entity.IExtendedEntity;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.StringConstants;
import com.taomee.seer2.core.utils.Util;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

public class Teleport extends AnimateElement implements IExtendedEntity {


    private const HOME_MAP_ID:uint = 50000;

    private const COPY_MAP_ID:uint = 80000;

    private const PLANT_MAP_ID:uint = 70000;

    private var _targetMapId:uint;

    private var _actorTargetPoint:Point;

    private var _spot:Sprite;

    public function Teleport() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.buttonMode = true;
    }

    public function setData(param1:XML):void {
        var _loc3_:Point = null;
        this.name = param1.attribute("name").toString();
        var _loc2_:String = param1.attribute("pos").toString();
        _loc3_ = Util.parsePositionStr(_loc2_);
        this.x = _loc3_.x;
        this.y = _loc3_.y;
        var _loc4_:String = param1.attribute("targetPos").toString();
        this._actorTargetPoint = Util.parsePositionStr(_loc4_);
        this._targetMapId = uint(param1.attribute("targetMapId").toString());
        this.addSpot();
        this.addTooltip();
        addEventListener(MouseEvent.CLICK, this.onMouseClick);
    }

    protected function addSpot():void {
        this._spot = TeleportResourcePool.checkOut();
        addChild(this._spot);
    }

    private function addTooltip():void {
        if (this.name != StringConstants.EMPTY) {
            TooltipManager.addCommonTip(this, this.name);
        }
    }

    private function removeTooltip():void {
        TooltipManager.remove(this);
    }

    public function onMouseClick(param1:MouseEvent):void {
        var _loc2_:Actor = ActorManager.getActor();
        var _loc3_:Boolean = this.isTargetArrived();
        if (_loc3_) {
            this.changeMap();
        } else {
            _loc2_.addEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
            _loc2_.runToLocation(this.x, this.y);
        }
        param1.stopImmediatePropagation();
    }

    protected function isTargetArrived():Boolean {
        var _loc1_:Actor = ActorManager.getActor();
        return _loc1_.x == this.x && _loc1_.y == this.y;
    }

    protected function onActorMoveFinished(param1:MoveEvent):void {
        ActorManager.getActor().removeEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
        var _loc2_:Boolean = this.isTargetArrived();
        if (_loc2_) {
            this.changeMap();
        }
    }

    protected function changeMap():void {
        var _loc1_:Actor = ActorManager.getActor();
        _loc1_.stand();
        if (this._targetMapId == this.HOME_MAP_ID) {
            SceneManager.changeScene(SceneType.HOME, ActorManager.actorInfo.id);
        }
        if (this._targetMapId == this.PLANT_MAP_ID) {
            SceneManager.changeScene(SceneType.PLANT, ActorManager.actorInfo.id);
        } else if (this._targetMapId < this.HOME_MAP_ID && this._targetMapId >= 10) {
            SceneManager.changeScene(SceneType.LOBBY, this._targetMapId, this._actorTargetPoint.x, this._actorTargetPoint.y);
        } else if (this._targetMapId > 0 && this._targetMapId < 10) {
            SceneManager.changeScene(SceneType.NOVICE, this._targetMapId, this._actorTargetPoint.x, this._actorTargetPoint.y);
        } else if (this._targetMapId > this.COPY_MAP_ID) {
            SceneManager.changeScene(SceneType.COPY, this._targetMapId, this._actorTargetPoint.x, this._actorTargetPoint.y);
        }
    }

    protected function checkPortInPool():void {
        TeleportResourcePool.checkIn(this._spot);
    }

    override public function dispose():void {
        ActorManager.getActor().removeEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
        this.checkPortInPool();
        this._spot = null;
        this.removeTooltip();
        super.dispose();
    }
}
}
