package com.taomee.seer2.app.copySystem {
import flash.events.Event;

public class CopyEvent extends Event {

    public static const COMPLETE:String = "complete";


    private var _copyItemId:int;

    public function CopyEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._copyItemId = param2;
    }

    public function get copyItemId():int {
        return this._copyItemId;
    }
}
}
