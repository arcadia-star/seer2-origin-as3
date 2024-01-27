package com.taomee.seer2.core.quest.data {
import flash.geom.Point;

public class QuestStepDefinition {


    public var id:int;

    public var name:String;

    public var sum:String;

    public var des:String;

    public var transport:String;

    public var dialogDefinition:DialogDefinition;

    public var relatedNpcId:int;

    public var income:QuestProductDefinition;

    public var outcome:QuestProductDefinition;

    public var targetDefinition:TargetDefinition;

    public var point:Point;

    public function QuestStepDefinition(param1:int, param2:int, param3:String, param4:String, param5:String, param6:String, param7:String) {
        super();
        this.id = param1;
        this.name = param3;
        this.sum = param4;
        this.des = param5;
        this.transport = param7;
        this.relatedNpcId = param2;
        if (param6.indexOf("|") > 0) {
            this.point = new Point(Number(param6.split("|")[0]), Number(param6.split("|")[1]));
        }
    }
}
}
