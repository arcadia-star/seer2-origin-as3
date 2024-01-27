package com.taomee.seer2.app.gameRule.data {
import flash.events.Event;

public class MapUserStatusEvent extends Event {

    public static const UPDATE:String = "UPDATE";


    private var _statusUser:MapUser;

    public function MapUserStatusEvent(param1:MapUser, param2:String, param3:Boolean = false, param4:Boolean = false) {
        super(param2, param3, param4);
        this._statusUser = param1;
    }

    override public function clone():Event {
        return new MapUserStatusEvent(this._statusUser, this.type, this.bubbles, this.cancelable);
    }

    public function get statusUser():MapUser {
        return this._statusUser;
    }
}
}
