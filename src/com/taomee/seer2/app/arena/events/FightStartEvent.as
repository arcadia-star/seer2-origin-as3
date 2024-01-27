package com.taomee.seer2.app.arena.events {
import flash.events.Event;

public class FightStartEvent extends Event {

    public static const START_SUCCESS:String = "START_SUCCESS";

    public static const START_ERROR:String = "START_ERROR";

    public static const FIGHT_OVER:String = "FIGHT_OVER";

    public static const FIGHT_LOADING_START:String = "FIGHT_LOADING_START";

    public static const FIGHT_LOADING_END:String = "FIGHT_LOADING_END";


    public function FightStartEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
