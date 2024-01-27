package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.NumberUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class KeepBalance extends BaseAniamationInteractive {

    private static const LEFT_KEY:int = 37;

    private static const RIGHT_KEY:int = 39;


    private var _countdown:int;

    private var _type:int;

    private var _tenMC:MovieClip;

    private var _digitMC:MovieClip;

    private var _thousandMC:MovieClip;

    private var _startAnimation:MovieClip;

    private var _actorMC:MovieClip;

    private var _floorMC:MovieClip;

    private var _backGroundMC:MovieClip;

    private var _timer:Timer;

    private var _count:int;

    private var _dTimer:Timer;

    private var _direction:int;

    private var _speed:int = 5;

    private var _randomTimer:Timer;

    private var _randomNum:int;

    public function KeepBalance(param1:int, param2:int) {
        this._countdown = param1;
        this._type = param2;
        super();
    }

    override protected function paramAnimation():void {
        this._tenMC = _animation["tenMC"];
        this._digitMC = _animation["digitMC"];
        this._thousandMC = _animation["thousandMC"];
        this._startAnimation = _animation["startAnimation"];
        this._actorMC = _animation["actor"];
        this._floorMC = _animation["floorMC"];
        this.gotoAndStop(this._floorMC);
        this.gotoAndStop(this._floorMC["floor"]);
        this.gotoAndStop(this._floorMC["left"]);
        this.gotoAndStop(this._floorMC["right"]);
        this.gotoAndStop(this._floorMC["up"]);
        this.gotoAndStop(this._floorMC["line"]);
        this._backGroundMC = _animation["backGroundMC"];
        this._backGroundMC.gotoAndStop(1);
        this.initTimers();
        this.updataTimer();
        this._randomNum = 3;
        this._count = 0;
        MovieClipUtil.playMc(this._startAnimation, 0, this._startAnimation.totalFrames, this.startGame);
        this._actorMC.addEventListener(Event.ENTER_FRAME, this.onActorEnterFramer);
    }

    private function initTimers():void {
        this._timer = new Timer(1000, this._countdown);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this._dTimer = new Timer(50);
        this._dTimer.addEventListener(TimerEvent.TIMER, this.onDTimer);
        this._randomTimer = new Timer(1000);
        this._randomTimer.addEventListener(TimerEvent.TIMER, this.onRandomTimer);
    }

    private function updataTimer():void {
        var _loc1_:String = "00" + this._count.toString();
        if (this._type == 1) {
            _loc1_ = "00" + (this._countdown - this._count).toString();
        }
        this._tenMC.gotoAndStop(int(_loc1_.substr(_loc1_.length - 2, 1)) + 1);
        this._digitMC.gotoAndStop(int(_loc1_.substr(_loc1_.length - 1, 1)) + 1);
        if (this._thousandMC) {
            this._thousandMC.gotoAndStop(int(_loc1_.substr(_loc1_.length - 3, 1)) + 1);
        }
    }

    private function startGame():void {
        this._startAnimation.stop();
        DisplayObjectUtil.removeFromParent(this._startAnimation);
        this._floorMC.gotoAndPlay(2);
        this.gotoAndPlay(this._floorMC["floor"]);
        this.gotoAndPlay(this._floorMC["left"]);
        this.gotoAndPlay(this._floorMC["right"]);
        this.gotoAndPlay(this._floorMC["up"]);
        this.gotoAndPlay(this._floorMC["line"]);
        this._backGroundMC.gotoAndPlay(2);
        this._timer.start();
        LayerManager.stage.focus = _animation;
        _animation.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        _animation.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        this._randomTimer.start();
    }

    private function gotoAndPlay(param1:MovieClip):void {
        if (param1 != null) {
            param1.gotoAndPlay(2);
        }
    }

    private function gotoAndStop(param1:MovieClip):void {
        if (param1 != null) {
            param1.gotoAndStop(1);
        }
    }

    private function onActorEnterFramer(param1:Event):void {
        var _loc2_:MovieClip = this._actorMC["mc"];
        if (this._actorMC.currentFrame != 1) {
            this.closeKeyEventListener();
            if (_loc2_.currentFrame == _loc2_.totalFrames) {
                this.dispose();
            }
        } else if (_loc2_.rotation <= -60 && _loc2_.rotation >= -90) {
            this._actorMC.gotoAndStop(3);
        } else if (_loc2_.rotation <= 90 && _loc2_.rotation >= 60) {
            this._actorMC.gotoAndStop(2);
        }
    }

    private function onTimer(param1:TimerEvent):void {
        ++this._count;
        this.updataTimer();
        if (this._count == this._countdown) {
            this.dispose();
        }
    }

    private function onKeyDown(param1:KeyboardEvent):void {
        if (param1.keyCode == LEFT_KEY) {
            this._direction = -1;
            this.diandianFall();
        } else if (param1.keyCode == RIGHT_KEY) {
            this._direction = 1;
            this.diandianFall();
        }
    }

    private function onDTimer(param1:TimerEvent):void {
        var _loc2_:MovieClip = this._actorMC["mc"];
        _loc2_.rotation += this._direction * this._speed;
    }

    private function onRandomTimer(param1:TimerEvent):void {
        if (this._randomTimer.currentCount == this._randomNum) {
            this._randomTimer.reset();
            this._randomTimer.start();
            this._randomNum = NumberUtil.random(1, 1);
            this._direction = NumberUtil.random(-50, 50) >= 0 ? 1 : -1;
            this.diandianFall();
        }
    }

    private function diandianFall():void {
        this._dTimer.reset();
        this._dTimer.start();
    }

    private function onKeyUp(param1:KeyboardEvent):void {
        this._dTimer.stop();
    }

    override public function dispose():void {
        super.hide();
        this._actorMC.removeEventListener(Event.ENTER_FRAME, this.onActorEnterFramer);
        this.closeKeyEventListener();
        this.clearTimers();
        _callBack(this._count);
    }

    private function clearTimers():void {
        this._timer.stop();
        this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
        this._dTimer.stop();
        this._dTimer.removeEventListener(TimerEvent.TIMER, this.onDTimer);
        this._randomTimer.stop();
        this._randomTimer.removeEventListener(TimerEvent.TIMER, this.onRandomTimer);
    }

    private function closeKeyEventListener():void {
        _animation.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        _animation.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
    }
}
}
