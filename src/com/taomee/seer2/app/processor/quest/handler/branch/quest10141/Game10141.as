package com.taomee.seer2.app.processor.quest.handler.branch.quest10141 {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.MathUtil;

public class Game10141 {


    private var _page1:MovieClip;

    private var _page2:MovieClip;

    private var _startBtn:SimpleButton;

    private var _closeBtn:SimpleButton;

    private var _tips:MovieClip;

    private var _upBnt:MovieClip;

    private var _leftBnt:MovieClip;

    private var _rightBnt:MovieClip;

    private var _time_mc:MovieClip;

    private var _seer:MovieClip;

    private var _lv:MovieClip;

    private var _game_num:int;

    private var _myTimer:Timer;

    private var _function:Function;

    public function Game10141(param1:MovieClip, param2:MovieClip, param3:Function) {
        this._myTimer = new Timer(2000, 1);
        super();
        LayerManager.focusOnTopLayer();
        this._function = param3;
        this._page1 = param1;
        this._page2 = param2;
        LayerManager.topLayer.addChild(this._page2);
        LayerManager.topLayer.addChild(this._page1);
        this._startBtn = this._page1["startBtn"];
        this._closeBtn = this._page1["closeBtn"];
        this._tips = this._page2["tips"];
        this._upBnt = this._page2["upMC"];
        this._leftBnt = this._page2["leftMC"];
        this._rightBnt = this._page2["rightMC"];
        this._time_mc = this._page2["jishi"];
        this._seer = this._page2["seer"];
        this._lv = this._page2["lv"];
        this._tips.gotoAndStop(1);
        this._upBnt.gotoAndStop(1);
        this._leftBnt.gotoAndStop(1);
        this._rightBnt.gotoAndStop(1);
        this._seer.gotoAndStop(1);
        this._lv.gotoAndStop(1);
        this._startBtn.addEventListener(MouseEvent.CLICK, this.onStartGameHandler);
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onCloseGameHandler);
    }

    private function onStartGameHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DisplayUtil.removeForParent(this._page1);
        this._time_mc.gotoAndPlay(2);
        this._time_mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (_time_mc.currentFrame == 62) {
                _time_mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                ChooseFight();
            }
        });
    }

    private function onCloseGameHandler(param1:MouseEvent):void {
        this.disposeGame();
    }

    private function ChooseFight():void {
        var _loc1_:int = int(MathUtil.randomRegion(1, 3));
        if (this._game_num < 10) {
            if (_loc1_ == 1) {
                this.StartFightOne();
            }
            if (_loc1_ == 2) {
                this.StartFightTwo();
            }
            if (_loc1_ == 3) {
                this.StartFightThree();
            }
        } else {
            this.disposeGame();
            if (this._function != null) {
                this._function();
                this._function = null;
            }
        }
    }

    private function StartFightOne():void {
        this._tips.visible = true;
        this._upBnt.gotoAndStop(2);
        this._tips.gotoAndStop(1);
        this.addTimeLose();
        this.initBtn();
        this._upBnt.addEventListener(MouseEvent.CLICK, this.onClickUpBtnHandler);
        this._leftBnt.addEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._rightBnt.addEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._lv.removeEventListener(Event.ENTER_FRAME, arguments.callee);
    }

    private function onClickUpBtnHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._tips.visible = false;
        this._myTimer.stop();
        this._upBnt.gotoAndStop(1);
        this.diposeBtn();
        this._upBnt.removeEventListener(MouseEvent.CLICK, this.onClickUpBtnHandler);
        this._leftBnt.removeEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._rightBnt.removeEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._game_num += 1;
        this._seer.gotoAndPlay(77);
        this._lv.gotoAndPlay(77);
        this._seer.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (_seer.currentFrame == 121) {
                _seer.gotoAndStop(1);
                _lv.gotoAndStop(1);
                _seer.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                ChooseFight();
            }
        });
    }

    private function StartFightTwo():void {
        this._leftBnt.gotoAndStop(2);
        this._tips.visible = true;
        this._tips.gotoAndStop(3);
        this.addTimeLose();
        this.initBtn();
        this._leftBnt.addEventListener(MouseEvent.CLICK, this.onClickLeftBtnHandler);
        this._upBnt.addEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._rightBnt.addEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._lv.removeEventListener(Event.ENTER_FRAME, arguments.callee);
    }

    private function onClickLeftBtnHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._myTimer.stop();
        this._tips.visible = false;
        this._leftBnt.gotoAndStop(1);
        this.diposeBtn();
        this._leftBnt.removeEventListener(MouseEvent.CLICK, this.onClickLeftBtnHandler);
        this._upBnt.removeEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._rightBnt.removeEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._game_num += 1;
        this._seer.gotoAndPlay(3);
        this._lv.gotoAndPlay(3);
        this._seer.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (_seer.currentFrame == 38) {
                _seer.gotoAndStop(1);
                _lv.gotoAndStop(1);
                _seer.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                ChooseFight();
            }
        });
    }

    private function StartFightThree():void {
        this._rightBnt.gotoAndStop(2);
        this._tips.visible = true;
        this._tips.gotoAndStop(2);
        this.addTimeLose();
        this.initBtn();
        this._rightBnt.addEventListener(MouseEvent.CLICK, this.onClickRightBtnHandler);
        this._leftBnt.addEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._upBnt.addEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._lv.removeEventListener(Event.ENTER_FRAME, arguments.callee);
    }

    private function onClickRightBtnHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._myTimer.stop();
        this._tips.visible = false;
        this._rightBnt.gotoAndStop(1);
        this.diposeBtn();
        this._rightBnt.removeEventListener(MouseEvent.CLICK, this.onClickRightBtnHandler);
        this._leftBnt.removeEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._upBnt.removeEventListener(MouseEvent.CLICK, this.onClickRongBtnHandler);
        this._game_num += 1;
        this._seer.gotoAndPlay(39);
        this._lv.gotoAndPlay(39);
        this._seer.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (_seer.currentFrame == 76) {
                _seer.gotoAndStop(1);
                _lv.gotoAndStop(1);
                _seer.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                ChooseFight();
            }
        });
    }

    private function onClickRongBtnHandler(param1:MouseEvent):void {
        this._myTimer.stop();
        this.serrRong();
    }

    private function addTimeLose():void {
        this._myTimer.start();
        this._myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.completeHandler);
    }

    private function completeHandler(param1:TimerEvent):void {
        this.serrRong();
    }

    private function serrRong():void {
        this._tips.visible = false;
        this._seer.gotoAndPlay(123);
        this._leftBnt.gotoAndStop(1);
        this._rightBnt.gotoAndStop(1);
        this._upBnt.gotoAndStop(1);
        this.diposeBtn();
        this._upBnt.removeEventListener(MouseEvent.CLICK, this.onClickUpBtnHandler);
        this._leftBnt.removeEventListener(MouseEvent.CLICK, this.onClickLeftBtnHandler);
        this._rightBnt.removeEventListener(MouseEvent.CLICK, this.onClickRightBtnHandler);
        this._seer.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (_seer.currentFrame == 152) {
                _seer.gotoAndStop(1);
                _lv.gotoAndStop(1);
                _seer.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                ChooseFight();
            }
        });
    }

    private function diposeBtn():void {
        this._upBnt.mouseEnabled = false;
        this._leftBnt.mouseEnabled = false;
        this._rightBnt.mouseEnabled = false;
        this._upBnt.mouseChildren = false;
        this._leftBnt.mouseChildren = false;
        this._rightBnt.mouseChildren = false;
    }

    private function initBtn():void {
        this._upBnt.mouseEnabled = true;
        this._leftBnt.mouseEnabled = true;
        this._rightBnt.mouseEnabled = true;
        this._upBnt.mouseChildren = true;
        this._leftBnt.mouseChildren = true;
        this._rightBnt.mouseChildren = true;
    }

    public function disposeGame():void {
        LayerManager.resetOperation();
        if (this._page1) {
            DisplayUtil.removeForParent(this._page1);
        }
        if (this._page2) {
            DisplayUtil.removeForParent(this._page2);
        }
        this._myTimer.stop();
    }
}
}
