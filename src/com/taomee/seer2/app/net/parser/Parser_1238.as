package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1238 {


    public var copyInfo:Vector.<int>;

    public function Parser_1238(param1:IDataInput) {
        super();
        this.copyInfo = new Vector.<int>();
        if (param1.bytesAvailable == 0) {
            return;
        }
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            this.copyInfo.push(param1.readUnsignedInt());
            _loc3_++;
        }
    }
}
}
