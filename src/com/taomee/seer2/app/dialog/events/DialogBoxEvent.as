package com.taomee.seer2.app.dialog.events {
import flash.events.Event;

public class DialogBoxEvent extends Event {

    public static const CUSTOM_REPLY_CLICK:String = "customReplayClick";

    public static const UPDATE_CONTENT:String = "updateContent";


    private var _content:*;

    public function DialogBoxEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._content = param2;
    }

    public function get content():* {
        return this._content;
    }
}
}
