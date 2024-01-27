package com.taomee.seer2.app.activity.onlineReward.powerTree {
import flash.events.Event;

public class CountDownTimerEvent extends Event {

    public static const TIMER_DOWN:String = "TIMER_DOWN";


    private var _min:uint;

    private var _sec:uint;

    public function CountDownTimerEvent(param1:String, param2:uint, param3:uint, param4:Boolean = false, param5:Boolean = false) {
        super(param1, param4, param5);
        this._min = param2;
        this._sec = param3;
    }

    public function get min():uint {
        return this._min;
    }

    public function get sec():uint {
        return this._sec;
    }
}
}
