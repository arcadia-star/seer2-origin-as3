package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1136 {


    public var category:uint;

    public var coins:uint;

    public function Parser_1136(param1:IDataInput) {
        super();
        this.category = param1.readUnsignedByte();
        this.coins = param1.readUnsignedInt();
    }
}
}
