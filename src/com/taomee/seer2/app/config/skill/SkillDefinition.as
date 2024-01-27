package com.taomee.seer2.app.config.skill {
public class SkillDefinition {


    public var id:int;

    public var name:String;

    public var category:int;

    public var type:int;

    public var anger:int;

    public var power:int;

    public var description:String;

    public function SkillDefinition(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:String) {
        super();
        this.id = param1;
        this.name = param2;
        this.category = param3;
        this.type = param4;
        this.anger = param5;
        this.power = param6;
        this.description = param7;
    }
}
}
