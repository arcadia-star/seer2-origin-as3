package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1065 {


    public var id:uint;

    public var count:uint;

    public function Parser_1065(param1:IDataInput) {
        super();
        this.id = param1.readUnsignedInt();
        this.count = param1.readUnsignedInt();
    }
}
}
