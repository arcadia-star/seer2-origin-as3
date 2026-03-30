package com.taomee.seer2.app.arena.processor {
public class ChangeFighterInfo {

    public var userId:uint;

    public var petCatchTime:Number;

    public var angerValue:uint;

    public var position:uint;

    public function ChangeFighterInfo(param1:uint, param2:Number, param3:uint, param4:uint) {
        this.userId = param1;
        this.petCatchTime = param2;
        this.angerValue = param3;
        this.position = param4;
        super();
    }
}
}
