package com.taomee.seer2.app.animationInteractive {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.taomee.utils.DisplayUtil;

public class Interactive_10011 extends BaseAniamationInteractive {


    private var _starMC:MovieClip;

    private var _shi:MovieClip;

    private var _findNumMC:MovieClip;

    private var _hammer:MovieClip;

    private var _hammerDown:MovieClip;

    private var _timeMC:MovieClip;

    private var _carMC:MovieClip;

    private var _doorMC:MovieClip;

    private var _timer:Timer;

    private var _yesNum:int = 0;

    private var _noNum:int = 0;

    private var RANDOM_VEC:Vector.<int>;

    public function Interactive_10011() {
        this.RANDOM_VEC = Vector.<int>([1, 53, 2, 53, 53, 53, 2, 53, 2, 53, 53]);
        super();
    }

    override protected function paramAnimation():void {
        this._starMC = _animation["starMC"];
        this._shi = _animation["shi"];
        this._findNumMC = _animation["findNumMC"];
        this._hammer = _animation["hammer"];
        this._hammerDown = _animation["hammerDown"];
        this._timeMC = _animation["timeMC"];
        this._carMC = _animation["carMC"];
        this._doorMC = _animation["doorMC"];
        this._timer = new Timer(1000, 30);
        this._doorMC.addEventListener(Event.ENTER_FRAME, this.onDoor);
        this._starMC.addEventListener(Event.ENTER_FRAME, this.onStar);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
    }

    private function onDoor(param1:Event):void {
        if (this._doorMC.currentFrame == 46) {
            this.noComplete();
        }
        if (this._doorMC.currentFrame == this._doorMC.totalFrames) {
            this._doorMC.removeEventListener(Event.ENTER_FRAME, this.onDoor);
            dispatchEvent(new Event(Event.CLOSE));
            this.dispose();
        }
    }

    private function noComplete():void {
        this._timer.stop();
        this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
        this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
        this._hammer.mouseEnabled = false;
        this._hammer.mouseChildren = false;
        this._doorMC.gotoAndPlay(113);
        this._carMC.gotoAndPlay(15);
    }

    private function onStar(param1:Event):void {
        if (this._starMC.currentFrame == this._starMC.totalFrames) {
            this.removeStar();
            this.star();
        }
    }

    private function star():void {
        this.animationPlayOrStop(true);
        this._timer.start();
        this._hammer.buttonMode = true;
        this._hammer.addEventListener(MouseEvent.CLICK, this.onHammerClick);
    }

    private function onTimer(param1:TimerEvent):void {
        if (this._timer.currentCount != 0 && this._timer.currentCount % 2 == 0) {
            this._timeMC.gotoAndStop(int(this._timer.currentCount / 2) + 1);
        }
        if (this._timer.currentCount != 0 && this._timer.currentCount % 3 == 0) {
            this._doorMC.gotoAndPlay(this.RANDOM_VEC[int(this._timer.currentCount / 3)]);
        }
    }

    private function onTimerComplete(param1:TimerEvent):void {
        if (this._yesNum >= 3) {
            dispatchEvent(new Event(AnimationEvent.STONE));
            this.dispose();
        } else {
            this._doorMC.removeEventListener(Event.ENTER_FRAME, this.onDoor);
            this.noComplete();
        }
    }

    private function onHammerClick(param1:MouseEvent):void {
        this._findNumMC.gotoAndStop(this._findNumMC.currentFrame + 1);
        if (this._doorMC.currentFrame >= 2 && this._doorMC.currentFrame < 45) {
            this._hammerDown.gotoAndPlay(2);
            ++this._yesNum;
        }
        if (this._doorMC.currentFrame >= 53 && this._doorMC.currentFrame <= 100) {
            this._hammerDown.gotoAndPlay(13);
            ++this._noNum;
        }
        if (this._doorMC.currentFrame == 1) {
            this._hammerDown.gotoAndPlay(13);
            ++this._noNum;
        }
        this._doorMC.gotoAndStop(1);
        if (this._findNumMC.currentFrame == this._findNumMC.totalFrames) {
            this._hammer.mouseChildren = false;
            this._hammer.mouseEnabled = false;
        }
    }

    private function animationPlayOrStop(param1:Boolean):void {
        if (param1) {
            this._shi.play();
            this._carMC.play();
            this._hammer.play();
        } else {
            this._shi.stop();
            this._carMC.stop();
            this._hammer.stop();
        }
    }

    private function removeDoor():void {
        if (this._doorMC) {
            this._doorMC.gotoAndStop(1);
            this._doorMC.removeEventListener(Event.ENTER_FRAME, this.onDoor);
            this._doorMC = null;
        }
    }

    private function removeTimer():void {
        if (this._timer) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this._timer = null;
        }
    }

    private function removeStar():void {
        if (this._starMC) {
            this._starMC.removeEventListener(Event.ENTER_FRAME, this.onStar);
            DisplayUtil.removeForParent(this._starMC);
            this._starMC = null;
        }
    }

    override public function dispose():void {
        this._yesNum = 0;
        this._noNum = 0;
        this.removeStar();
        this.removeTimer();
        this._findNumMC.gotoAndStop(1);
        this._findNumMC = null;
        this.animationPlayOrStop(false);
        this.removeDoor();
        this._timeMC.gotoAndStop(1);
        this._carMC.gotoAndStop(1);
        this._carMC = null;
        this._timeMC = null;
        this._shi = null;
        this._carMC = null;
        this._hammer = null;
        super.dispose();
    }
}
}
