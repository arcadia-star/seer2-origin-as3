package com.taomee.seer2.app.dialog.events {
import flash.events.Event;

public class FunctionalityBoxEvent extends Event {

    public static const CUSTOM_UNIT_CLICK:String = "customUnitClick";

    public static const QUEST_CLICK:String = "questClick";

    public static const QUEST_NEW_CLICK:String = "questNewClick";


    private var _content:*;

    public function FunctionalityBoxEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._content = param2;
    }

    public function get content():* {
        return this._content;
    }

    override public function clone():Event {
        return new FunctionalityBoxEvent(type, this._content);
    }
}
}
