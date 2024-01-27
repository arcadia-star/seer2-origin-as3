package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1269 {


    public var changePropList:Vector.<int>;

    public var basePropList:Vector.<int>;

    public function Parser_1269(param1:IDataInput) {
        super();
        this.changePropList = new Vector.<int>();
        this.basePropList = new Vector.<int>();
        this.changePropList.push(param1.readUnsignedInt());
        this.changePropList.push(param1.readUnsignedInt());
        this.changePropList.push(param1.readUnsignedInt());
        this.changePropList.push(param1.readUnsignedInt());
        this.changePropList.push(param1.readUnsignedInt());
        this.changePropList.push(param1.readUnsignedInt());
        this.basePropList.push(param1.readUnsignedInt());
        this.basePropList.push(param1.readUnsignedInt());
        this.basePropList.push(param1.readUnsignedInt());
        this.basePropList.push(param1.readUnsignedInt());
        this.basePropList.push(param1.readUnsignedInt());
        this.basePropList.push(param1.readUnsignedInt());
    }
}
}
