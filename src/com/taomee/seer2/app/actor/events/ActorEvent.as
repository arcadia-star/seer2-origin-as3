package com.taomee.seer2.app.actor.events {
import flash.events.Event;

public class ActorEvent extends Event {

    public static const ACTOR_ENTER_MAP:String = "actorEnterMap";

    public static const ACTOR_LEAVE_MAP:String = "actorLeaveMap";

    public static const ACTOR_SYNC_SVR:String = "actorSyncSvr";

    public static const ACTOR_ONHOOK_WALK:String = "actorOnhookWalk";


    public function ActorEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
