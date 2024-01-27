package com.taomee.seer2.app.config.item {
public class PetItemDefinition extends BasisItemDefinition {


    public var bonus:Number;

    public var minLevel:int;

    public var maxLevel:int;

    public var experience:int;

    public var hp:int;

    public var type:int;

    public var sellPrice:int;

    public var swapId:int;

    public function PetItemDefinition(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:int, param7:int, param8:Boolean, param9:Boolean, param10:int, param11:String, param12:Number, param13:int, param14:int, param15:String, param16:int, param17:int, param18:int) {
        super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        this.bonus = param12;
        this.hp = param13;
        this.experience = param14;
        var _loc19_:Array = param15.split(" ");
        this.minLevel = int(_loc19_[0]);
        this.maxLevel = int(_loc19_[1]);
        this.type = param16;
        this.sellPrice = param17;
        this.swapId = param18;
    }
}
}
