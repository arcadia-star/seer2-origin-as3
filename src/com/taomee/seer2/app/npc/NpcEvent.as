package com.taomee.seer2.app.npc {
import com.taomee.seer2.core.entity.definition.NpcDefinition;

import flash.events.Event;

public class NpcEvent extends Event {

    public static const ACTOR_ARRIVE:String = "actorArrive";

    public static const CLICK_NPC:String = "CLICK_NPC";

    public static const NPC_TALK_QUEST_FUNC:String = "npcTalkFunc";


    public var npcDefinition:NpcDefinition;

    public function NpcEvent(param1:String, param2:NpcDefinition, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this.npcDefinition = param2;
    }
}
}
