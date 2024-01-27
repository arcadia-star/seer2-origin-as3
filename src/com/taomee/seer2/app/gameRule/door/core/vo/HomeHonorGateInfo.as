package com.taomee.seer2.app.gameRule.door.core.vo {
import flash.utils.IDataInput;

public class HomeHonorGateInfo {


    public var id:int;

    public var pveNormal:int;

    public var pveFifty:int;

    public var pvelastNormal:int;

    public var pvelastFifty:int;

    public function HomeHonorGateInfo(param1:IDataInput) {
        super();
        this.id = param1.readUnsignedByte();
        this.pveNormal = param1.readUnsignedByte();
        this.pveFifty = param1.readUnsignedByte();
        this.pvelastNormal = param1.readUnsignedByte() + 1;
        this.pvelastFifty = param1.readUnsignedByte() + 1;
    }
}
}
