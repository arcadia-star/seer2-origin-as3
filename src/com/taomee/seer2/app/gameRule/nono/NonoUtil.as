package com.taomee.seer2.app.gameRule.nono {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.LittleEndianByteArray;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class NonoUtil {

    private static var _timer:Timer;

    private static var _timerFlag:Boolean = true;

    private static var _dispatcher:EventDispatcher = new EventDispatcher();


    public function NonoUtil() {
        super();
    }

    public static function get isShow():Boolean {
        return ActorManager.actorInfo.getNonoInfo().isFollowing;
    }

    public static function show():void {
        var _loc1_:LittleEndianByteArray = null;
        if (isShow == false) {
            _loc1_ = new LittleEndianByteArray();
            _loc1_.writeByte(1);
            Connection.send(CommandSet.SET_NONO_FLAG_1194, _loc1_);
        }
    }

    public static function hide():void {
        var _loc1_:LittleEndianByteArray = null;
        if (isShow == true) {
            _loc1_ = new LittleEndianByteArray();
            _loc1_.writeByte(0);
            Connection.send(CommandSet.SET_NONO_FLAG_1194, _loc1_);
        }
    }

    public static function startLottoTimer():void {
        _timer = new Timer(1000, 10 * 60);
        _timer.addEventListener(TimerEvent.TIMER, onTimer);
        _timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
        _timer.start();
    }

    private static function onTimer(param1:TimerEvent):void {
        var _loc2_:NonoInfoEvent = new NonoInfoEvent(NonoInfoEvent.NONO_TIMER);
        _loc2_.seconds = 10 * 60 - _timer.currentCount;
        dispatchEvent(_loc2_);
    }

    private static function onTimerComplete(param1:TimerEvent):void {
        _timer.removeEventListener(TimerEvent.TIMER, onTimer);
        _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
        _timer = null;
        _timerFlag = true;
        var _loc2_:NonoInfoEvent = new NonoInfoEvent(NonoInfoEvent.NONO_TIMER_COMPLETE);
        _loc2_.seconds = 0;
        dispatchEvent(_loc2_);
    }

    public static function get timerFlag():Boolean {
        return _timerFlag;
    }

    public static function set timerFlag(param1:Boolean):void {
        _timerFlag = param1;
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _dispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _dispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:Event):void {
        if (_dispatcher.hasEventListener(param1.type)) {
            _dispatcher.dispatchEvent(param1);
        }
    }

    public static function hasEventListener(param1:String):Boolean {
        return _dispatcher.hasEventListener(param1);
    }
}
}
