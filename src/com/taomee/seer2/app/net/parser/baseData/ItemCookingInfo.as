package com.taomee.seer2.app.net.parser.baseData {
import flash.utils.IDataInput;

public class ItemCookingInfo {


    public var id:uint;

    public var count:uint;

    public function ItemCookingInfo(param1:IDataInput) {
        super();
        this.id = param1.readUnsignedInt();
        this.count = param1.readUnsignedShort();
    }
}
}
