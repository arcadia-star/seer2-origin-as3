package com.taomee.seer2.app.mail {
import flash.events.Event;

public class GmailEvent extends Event {

    public static const CLICK_TO_READ_MAIL:String = "CLICK_TO_READ_MAIL";

    public static const CLICK_SELECT_ALL_BTN:String = "CLICK_SELECT_ALL_BTN";

    public static const LIST_PANEL_PAGE_CHANGED:String = "LIST_PANEL_PAGE_CHANGED";

    public static const RETURN_FROM_READ:String = "RETURN_FROM_READ";

    public static const MAIL_SORT_COMPLETED:String = "MAIL_SORT_COMPLETED";

    public static const INIT_MAIL_COMPLETED:String = "INIT_MAIL_COMPLETED";


    private var _data:*;

    public function GmailEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }

    public function set data(param1:*):void {
        this._data = param1;
    }

    public function get data():* {
        return this._data;
    }
}
}
