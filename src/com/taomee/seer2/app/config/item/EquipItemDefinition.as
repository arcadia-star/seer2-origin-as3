package com.taomee.seer2.app.config.item {
public class EquipItemDefinition extends BasisItemDefinition {


    public var slotIndex:int;

    public var suitId:int;

    public var leftDay:int;

    public var timeLimit:int;

    public function EquipItemDefinition(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:int, param7:int, param8:Boolean, param9:Boolean, param10:int, param11:String, param12:int, param13:int, param14:int, param15:int) {
        super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        this.slotIndex = param12;
        this.suitId = param13;
        this.leftDay = param14;
        this.timeLimit = param15;
    }
}
}
