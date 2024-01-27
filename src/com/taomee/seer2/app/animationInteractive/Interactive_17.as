package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class Interactive_17 extends BaseAniamationInteractive {


    private var _book:MovieClip;

    private var _car:MovieClip;

    private var _obj:MovieClip;

    private var _timer:Timer;

    private var _num:int;

    public function Interactive_17() {
        super();
    }

    override protected function paramAnimation():void {
        this._book = _animation["book"];
        this._car = _animation["car"];
        this._obj = _animation["obj"];
        this._timer = new Timer(1000);
        this._car.buttonMode = true;
        this._num = 0;
        this._car.addEventListener(MouseEvent.CLICK, this.onClick);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
    }

    private function onClick(param1:MouseEvent):void {
        this._timer.start();
        this._car.gotoAndStop("鼠标跟随");
        this._book.gotoAndStop("洒粉提示");
        this._car.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event):void {
        this._car.x = LayerManager.stage.mouseX;
        this._car.y = LayerManager.stage.mouseY;
        if (this._car.hitTestObject(this._obj)) {
            this._car.gotoAndStop("洒粉动画");
        } else {
            this._car.gotoAndStop("鼠标跟随");
        }
    }

    private function onTimer(param1:TimerEvent):void {
        if (this._car.hitTestObject(this._book)) {
            ++this._num;
        }
        if (this._num >= 10) {
            this._timer.stop();
            this._car.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._car.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._car.gotoAndStop("鼠标跟随");
            this.win();
        }
    }

    private function win():void {
        MovieClipUtil.playMc(this._book, 44, this._book.totalFrames, function ():void {
            _isSuccess = true;
            dispose();
        }, true);
    }

    override public function dispose():void {
        if (this._timer) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
        }
        if (this._car) {
            this._car.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._car.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
        this._timer = null;
        this._book = null;
        this._car = null;
        this._num = 0;
        super.dispose();
    }
}
}
