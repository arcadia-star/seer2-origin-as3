package com.taomee.seer2.app.config.item {
public class CollectionItemDefinition extends BasisItemDefinition {


    public var rule:String;

    public var sellPrice:Number;

    public var type:int;

    public function CollectionItemDefinition(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:int, param7:int, param8:Boolean, param9:Boolean, param10:int, param11:String, param12:String, param13:Number, param14:int) {
        super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        this.rule = param12;
        this.sellPrice = param13;
        this.type = param14;
    }
}
}
