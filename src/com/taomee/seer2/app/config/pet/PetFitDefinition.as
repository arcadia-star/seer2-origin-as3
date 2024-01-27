package com.taomee.seer2.app.config.pet {
public class PetFitDefinition {


    public var id:uint;

    public var fatherId:uint;

    public var motherId:uint;

    public var skillId:uint;

    public var anger:uint;

    public var type:String;

    public var content:uint;

    public var special:String;

    public function PetFitDefinition(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:String, param7:uint, param8:String) {
        super();
        this.id = param1;
        this.fatherId = param2;
        this.motherId = param3;
        this.skillId = param4;
        this.anger = param5;
        this.type = param6;
        this.content = param7;
        this.special = param8;
    }
}
}
