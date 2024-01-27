package com.taomee.seer2.app.gameRule.door.core.vo {
import flash.utils.IDataInput;

public class HomeHonorSptInfo {


    public var id:int;

    public var status:int;

    public function HomeHonorSptInfo(param1:IDataInput) {
        super();
        this.id = param1.readUnsignedInt();
        this.status = param1.readUnsignedByte();
    }
}
}
