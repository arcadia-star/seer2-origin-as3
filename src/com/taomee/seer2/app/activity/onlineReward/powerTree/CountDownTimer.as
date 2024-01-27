package com.taomee.seer2.app.activity.onlineReward.powerTree {
import flash.display.MovieClip;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.taomee.manager.EventManager;

public class CountDownTimer {


    public var _countdownTimer:Timer;

    private var _sec:int;

    private var TimerUI:MovieClip;

    private var light_mc:MovieClip;

    public function CountDownTimer(param1:MovieClip, param2:int) {
        super();
        this._sec = param2;
        this._countdownTimer = new Timer(1000, param2);
        this._countdownTimer.addEventListener(TimerEvent.TIMER, this.countdownEvery);
        this._countdownTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.countdownOver);
        this._countdownTimer.start();
    }

    private function countdownEvery(param1:TimerEvent):void {
        var _loc2_:int = this._sec - this._countdownTimer.currentCount;
        var _loc3_:int = int(_loc2_ / 3600);
        var _loc4_:int = int(_loc2_ / 60);
        var _loc5_:int = _loc2_ % 60;
        if (_loc4_ >= 0 && _loc5_ >= 0) {
        }
        EventManager.dispatchEvent(new CountDownTimerEvent(CountDownTimerEvent.TIMER_DOWN, _loc4_, _loc5_));
    }

    public function showscore(param1:MovieClip, param2:uint):void {
        var _loc6_:uint = 0;
        var _loc3_:uint = 0;
        while (_loc3_ < param1.numChildren) {
            param1["mc" + _loc3_].gotoAndStop(1);
            _loc3_++;
        }
        var _loc4_:Array = (_loc4_ = param2.toString().split("")).reverse();
        var _loc5_:uint = 0;
        while (_loc5_ < _loc4_.length) {
            _loc6_ = uint(uint(_loc4_[_loc5_]) + 1);
            param1["mc" + _loc5_].gotoAndStop(_loc6_);
            _loc5_++;
        }
    }

    private function countdownOver(param1:TimerEvent = null):void {
        this._countdownTimer.removeEventListener(TimerEvent.TIMER, this.countdownEvery);
        this._countdownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.countdownOver);
        this._countdownTimer = null;
    }

    public function destroy():void {
        this.TimerUI = null;
        this._countdownTimer.stop();
        this._countdownTimer.removeEventListener(TimerEvent.TIMER, this.countdownEvery);
        this._countdownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.countdownOver);
        this._countdownTimer = null;
    }
}
}
