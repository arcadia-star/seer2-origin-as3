package com.taomee.seer2.app.dream {
import flash.utils.IDataInput;

public class DreamItem {


    public var itemId:uint;

    public var count:uint;

    public function DreamItem(param1:IDataInput) {
        super();
        this.itemId = param1.readUnsignedInt();
        this.count = param1.readUnsignedInt();
    }
}
}
