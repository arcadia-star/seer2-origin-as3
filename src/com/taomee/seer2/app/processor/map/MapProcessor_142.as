package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.gameRule.spt.SptBultoSupport;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_142 extends TitleMapProcessor {

    private static var _isShow:Boolean;

    private static const FIGHT_DAY:int = 853;


    private var _lightning:MovieClip;

    private var _stoneDragging:MovieClip;

    private var _peekaboo:MovieClip;

    public function MapProcessor_142(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initLightning();
        this.initStoneDragging();
        this.initPeekaboo();
        SptBultoSupport.getInstance().init(_map);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_129);
        this.foodPigActInit();
    }

    private function foodPigActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.bossId == 17) {
            DayLimitManager.getDoCount(FIGHT_DAY, function (param1:int):void {
                if (!_isShow) {
                    if (param1 >= 10) {
                        ServerMessager.addMessage("布鲁托今天的饭团已经都给你啦，明天再来和他打吧！");
                        _isShow = true;
                    }
                }
            });
        }
    }

    private function initLightning():void {
        this._lightning = _map.content["lightning"];
        this._lightning.gotoAndStop(2);
    }

    private function initStoneDragging():void {
        this._stoneDragging = _map.content["stoneDragging"];
        this._stoneDragging.gotoAndStop(1);
        this._stoneDragging.addEventListener(Event.FRAME_CONSTRUCTED, this.onTriggerFrameConstructed);
        this._stoneDragging.addEventListener(MouseEvent.CLICK, this.onClick);
        initInteractor(this._stoneDragging);
    }

    private function initPeekaboo():void {
        this._peekaboo = _map.ground["peekaboo"];
        this._peekaboo.addEventListener(Event.FRAME_CONSTRUCTED, this.onTriggerFrameConstructed);
        this._peekaboo.addEventListener(MouseEvent.CLICK, this.onClick);
        initInteractor(this._peekaboo);
        this._peekaboo.gotoAndStop(1);
    }

    private function onCartoonEnterFrame(param1:Event):void {
        var _loc3_:MovieClip = null;
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_.currentFrame == _loc2_.totalFrames) {
            _loc3_ = _loc2_.parent as MovieClip;
            _loc3_.gotoAndStop(1);
            _loc2_.removeEventListener(Event.ENTER_FRAME, this.onCartoonEnterFrame);
            initInteractor(_loc3_);
        }
    }

    private function onTriggerFrameConstructed(param1:Event):void {
        var _loc3_:MovieClip = null;
        var _loc2_:MovieClip = param1.target as MovieClip;
        _loc2_.mouseChildren = false;
        if (_loc2_.currentFrame == 2) {
            _loc3_ = _loc2_.getChildAt(0) as MovieClip;
            _loc3_.addEventListener(Event.ENTER_FRAME, this.onCartoonEnterFrame);
        }
    }

    private function onClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        closeInteractor(_loc2_);
        _loc2_.gotoAndStop(2);
        param1.stopPropagation();
    }

    private function clearEventListener(param1:Sprite):void {
        param1.removeEventListener(Event.FRAME_CONSTRUCTED, this.onTriggerFrameConstructed);
        param1.removeEventListener(MouseEvent.CLICK, this.onClick);
    }

    override public function dispose():void {
        this.clearEventListener(this._stoneDragging);
        this.clearEventListener(this._peekaboo);
        SptBultoSupport.getInstance().dispose();
        this._stoneDragging = null;
        this._peekaboo = null;
        this._lightning = null;
        super.dispose();
    }
}
}
