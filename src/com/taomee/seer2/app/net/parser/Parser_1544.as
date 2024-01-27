package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1544 {


    public var catchTime:uint;

    public var evolveLevel:uint;

    public function Parser_1544(param1:IDataInput) {
        super();
        this.catchTime = param1.readUnsignedInt();
        this.evolveLevel = param1.readUnsignedInt();
    }
}
}
