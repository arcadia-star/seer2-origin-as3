package com.taomee.seer2.app.dialog.events {
import flash.events.Event;

public class DialogPanelEvent extends Event {

    public static const DIALOG_CLOSED:String = "dialogClosed";

    public static const DIALOG_SHOW:String = "dialogShow";

    public static const CUSTOM_UNIT_CLICK:String = "customUnitClick";

    public static const CUSTOM_REPLY_CLICK:String = "customReplyClick";

    public static const QUEST_UNIT_CLICK:String = "questUnitClick";

    public static const NPC_QUEST_CLICK:String = "npcQuestClick";


    private var _dialogId:uint;

    private var _content:*;

    public function DialogPanelEvent(param1:String, param2:uint = 0, param3:* = undefined, param4:Boolean = false, param5:Boolean = false) {
        super(param1, param4, param5);
        this._dialogId = param2;
        this._content = param3;
    }

    public function get content():* {
        return this._content;
    }

    public function get dialogId():uint {
        return this._dialogId;
    }

    override public function clone():Event {
        return new DialogPanelEvent(type, this.content);
    }
}
}
