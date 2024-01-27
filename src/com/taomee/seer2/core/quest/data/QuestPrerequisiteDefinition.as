package com.taomee.seer2.core.quest.data {
public class QuestPrerequisiteDefinition {


    public var preQuestIdVec:Vector.<int>;

    public var petLevel:int;

    public function QuestPrerequisiteDefinition(param1:Array, param2:int) {
        super();
        this.preQuestIdVec = Vector.<int>(param1);
        this.petLevel = param2;
    }
}
}
