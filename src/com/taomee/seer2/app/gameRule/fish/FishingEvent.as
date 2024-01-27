package com.taomee.seer2.app.gameRule.fish {
import flash.events.Event;

public class FishingEvent extends Event {

    public static const FISHING:String = "fishing";


    public var itemId:uint;

    public function FishingEvent(param1:uint, param2:String, param3:Boolean = false, param4:Boolean = false) {
        super(param2, param3, param4);
        this.itemId = param1;
    }
}
}
