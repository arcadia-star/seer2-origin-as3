package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_121 extends TitleMapProcessor {


    private var _npc17:Mobile;

    private const ACTION_STAND:String = "站立";

    private var _leftRuberGame:MovieClip;

    private var _rightRuberGame:MovieClip;

    private var _leftMushroom:MovieClip;

    private var _rightMushroom:MovieClip;

    private var _popMushroomTrigger:MovieClip;

    private var _hidingCount:uint = 0;

    public function MapProcessor_121(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initLeftRuberGame();
        this.initRightRuberGame();
        this.initLeftMushroom();
        this.initRightMushroom();
        this.initPopMushroomTrigger();
        this.processNpc();
        super.init();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_121);
    }

    private function initLeftRuberGame():void {
        this._leftRuberGame = _map.content["leftRuberGame"];
        initInteractor(this._leftRuberGame);
        this._leftRuberGame.addEventListener(Event.ENTER_FRAME, this.onRuberEnterFrame);
        this._leftRuberGame.addEventListener(MouseEvent.CLICK, this.onRuberClick);
    }

    private function initRightRuberGame():void {
        this._rightRuberGame = _map.content["rightRuberGame"];
        initInteractor(this._rightRuberGame);
        this._rightRuberGame.addEventListener(Event.ENTER_FRAME, this.onRuberEnterFrame);
        this._rightRuberGame.addEventListener(MouseEvent.CLICK, this.onRuberClick);
    }

    private function onRuberEnterFrame(param1:Event):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_.currentFrameLabel == "常态动画结束") {
            _loc2_.gotoAndPlay("常态动画");
        } else if (_loc2_.currentFrameLabel == "点击动画结束") {
            _loc2_.gotoAndPlay("常态动画");
            initInteractor(_loc2_);
            this.reward();
        }
    }

    private function reward():void {
        if (SwapManager.isSwapNumberMax(13)) {
            SwapManager.entrySwap(13);
        }
    }

    private function onRuberClick(param1:MouseEvent):void {
        param1.stopPropagation();
        var _loc2_:MovieClip = param1.target as MovieClip;
        _loc2_.gotoAndPlay("点击动画");
        closeInteractor(_loc2_);
    }

    private function initLeftMushroom():void {
        this._leftMushroom = _map.content["leftMushroom"];
        initInteractor(this._leftMushroom);
        this._leftMushroom.addEventListener(Event.ENTER_FRAME, this.onMushroomEnterFrame);
        this._leftMushroom.addEventListener(MouseEvent.CLICK, this.onMushroomClick);
    }

    private function initRightMushroom():void {
        this._rightMushroom = _map.content["rightMushroom"];
        initInteractor(this._rightMushroom);
        this._rightMushroom.addEventListener(Event.ENTER_FRAME, this.onMushroomEnterFrame);
        this._rightMushroom.addEventListener(MouseEvent.CLICK, this.onMushroomClick);
    }

    private function initPopMushroomTrigger():void {
        this._popMushroomTrigger = _map.content["popUpTrigger"];
        closeInteractor(this._popMushroomTrigger);
    }

    private function onMushroomEnterFrame(param1:Event):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_.currentFrameLabel == "常态动画结束") {
            _loc2_.gotoAndStop("常态动画");
        } else if (_loc2_.currentFrameLabel == "hidingStop") {
            _loc2_.stop();
            if (this._hidingCount == 2) {
                initInteractor(this._popMushroomTrigger);
                this._popMushroomTrigger.addEventListener(MouseEvent.CLICK, this.onPopTriggerClick);
            }
        } else if (_loc2_.currentFrameLabel == "end") {
            _loc2_.gotoAndPlay("常态动画");
            initInteractor(_loc2_);
        }
    }

    private function onMushroomClick(param1:MouseEvent):void {
        ++this._hidingCount;
        var _loc2_:MovieClip = param1.target as MovieClip;
        closeInteractor(_loc2_);
        _loc2_.gotoAndPlay("hidingStart");
        param1.stopPropagation();
    }

    private function onPopTriggerClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        closeInteractor(_loc2_);
        this._leftMushroom.gotoAndPlay("popStart");
        this._rightMushroom.gotoAndPlay("popStart");
        this._hidingCount = 0;
        _loc2_.removeEventListener(MouseEvent.CLICK, this.onPopTriggerClick);
        param1.stopPropagation();
    }

    private function clearEventListener():void {
        this._leftRuberGame.removeEventListener(Event.ENTER_FRAME, this.onRuberEnterFrame);
        this._leftRuberGame.removeEventListener(MouseEvent.CLICK, this.onRuberClick);
        this._rightRuberGame.removeEventListener(Event.ENTER_FRAME, this.onRuberEnterFrame);
        this._rightRuberGame.removeEventListener(MouseEvent.CLICK, this.onRuberClick);
        this._leftMushroom.removeEventListener(Event.ENTER_FRAME, this.onMushroomEnterFrame);
        this._leftMushroom.removeEventListener(MouseEvent.CLICK, this.onMushroomClick);
        this._rightMushroom.removeEventListener(Event.ENTER_FRAME, this.onMushroomEnterFrame);
        this._rightMushroom.removeEventListener(MouseEvent.CLICK, this.onMushroomClick);
        if (this._popMushroomTrigger.hasEventListener(MouseEvent.CLICK)) {
            this._popMushroomTrigger.removeEventListener(MouseEvent.CLICK, this.onPopTriggerClick);
        }
    }

    private function processNpc():void {
        this._npc17 = MobileManager.getMobile(17, MobileType.NPC);
        if (this._npc17 != null) {
            this._npc17.action = this.ACTION_STAND;
        }
    }

    override public function dispose():void {
        this.clearEventListener();
        this._leftRuberGame = null;
        this._rightRuberGame = null;
        this._leftMushroom = null;
        this._rightMushroom = null;
        this._popMushroomTrigger = null;
        this._npc17 = null;
        super.dispose();
    }
}
}
