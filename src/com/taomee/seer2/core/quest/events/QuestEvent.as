package com.taomee.seer2.core.quest.events {
import flash.events.Event;

public class QuestEvent extends Event {

    public static const INIT:String = "init";

    public static const ACCEPT:String = "accept";

    public static const ABORT:String = "abort";

    public static const STEP_UPDATE_BUFFER:String = "stepUpdateBuffer";

    public static const STEP_COMPLETE:String = "stepComplete";

    public static const COMPLETE:String = "complete";

    public static const RES_LOAD_COMPLETE:String = "resLoadComplete";


    private var _questId:int;

    private var _stepId:int;

    public function QuestEvent(param1:String, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false) {
        super(param1, param4, param5);
        this._questId = param2;
        this._stepId = param3;
    }

    public function get questId():int {
        return this._questId;
    }

    public function get stepId():int {
        return this._stepId;
    }
}
}
