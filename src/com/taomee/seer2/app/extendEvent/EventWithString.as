package com.taomee.seer2.app.extendEvent {
import flash.events.Event;

public class EventWithString extends Event {


    public var _str:String;

    public function EventWithString(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false) {
        this._str = param2;
        super(param1, param3, param4);
    }
}
}
