package com.taomee.seer2.app.dialog.events {
import flash.events.Event;

public class DialogCloseEvent extends Event {


    private var _params:String;

    public function DialogCloseEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) {
        super(param2, param3, param4);
        this._params = param1;
    }

    public function get params():String {
        return this._params;
    }

    override public function clone():Event {
        return new DialogCloseEvent(this._params, type, bubbles, cancelable);
    }
}
}
