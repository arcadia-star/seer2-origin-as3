package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_132 extends TitleMapProcessor {


    private var _mushroomLeft:MovieClip;

    private var _mushroomMiddle:MovieClip;

    private var _mushroomRight:MovieClip;

    private var _flower:MovieClip;

    public function MapProcessor_132(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initMushroomLeft();
        this.initMushroomMid();
        this.initFlower();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_125);
    }

    private function initMushroomLeft():void {
        this._mushroomLeft = _map.content["mushroomLeft"];
        this._mushroomLeft.addEventListener(Event.ENTER_FRAME, this.onCartoonEnterFrame);
        this._mushroomLeft.addEventListener(MouseEvent.CLICK, this.onClick);
        initInteractor(this._mushroomLeft);
    }

    private function initMushroomMid():void {
        this._mushroomMiddle = _map.content["mushroomMid"];
        this._mushroomMiddle.addEventListener(Event.ENTER_FRAME, this.onCartoonEnterFrame);
        this._mushroomMiddle.addEventListener(MouseEvent.CLICK, this.onClick);
        initInteractor(this._mushroomMiddle);
    }

    private function onCartoonEnterFrame(param1:Event):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_.currentFrameLabel == "常态动画结束") {
            _loc2_.gotoAndPlay("常态动画");
        } else if (_loc2_.currentFrame == _loc2_.totalFrames) {
            _loc2_.gotoAndPlay(1);
            initInteractor(_loc2_);
        }
    }

    private function onClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        closeInteractor(_loc2_);
        _loc2_.gotoAndPlay("点击");
        param1.stopPropagation();
    }

    private function initFlower():void {
        this._flower = _map.content["flower"];
        this._flower.addEventListener(Event.ENTER_FRAME, this.onFlowerEnterFrame);
        this._flower.addEventListener(MouseEvent.CLICK, this.onFlowerClick);
        initInteractor(this._flower);
        this._flower.gotoAndStop(1);
    }

    private function onFlowerEnterFrame(param1:Event):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_.currentFrame == _loc2_.totalFrames) {
            _loc2_.gotoAndStop(1);
            initInteractor(_loc2_);
        }
    }

    private function onFlowerClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        closeInteractor(_loc2_);
        _loc2_.gotoAndPlay(1);
        param1.stopPropagation();
    }

    private function clearEventListener(param1:Sprite):void {
        param1.removeEventListener(Event.ENTER_FRAME, this.onCartoonEnterFrame);
        param1.removeEventListener(MouseEvent.CLICK, this.onClick);
    }

    override public function dispose():void {
        this.clearEventListener(this._mushroomLeft);
        this.clearEventListener(this._mushroomMiddle);
        this._flower.removeEventListener(Event.ENTER_FRAME, this.onFlowerEnterFrame);
        this._flower.removeEventListener(MouseEvent.CLICK, this.onFlowerClick);
        this._mushroomLeft = null;
        this._mushroomMiddle = null;
        this._mushroomRight = null;
        this._flower = null;
        super.dispose();
    }
}
}
