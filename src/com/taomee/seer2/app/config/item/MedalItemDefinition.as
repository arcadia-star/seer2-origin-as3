package com.taomee.seer2.app.config.item {
public class MedalItemDefinition extends BasisItemDefinition {


    public var level:int;

    public var title:String;

    public var type:int;

    public function MedalItemDefinition(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:int, param7:int, param8:Boolean, param9:Boolean, param10:int, param11:String, param12:int, param13:int, param14:String) {
        super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        this.type = param12;
        this.level = param13;
        this.title = param14;
    }
}
}
