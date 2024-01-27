package com.taomee.seer2.app.net.parser {
import flash.utils.Dictionary;
import flash.utils.IDataInput;

public class Parser_1219 {


    public var type:uint;

    public var dataMap:Dictionary;

    public function Parser_1219(param1:IDataInput) {
        this.dataMap = new Dictionary();
        super();
        this.type = param1.readUnsignedInt();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            this.dataMap[param1.readUnsignedInt()] = param1.readUnsignedInt();
            _loc3_++;
        }
    }
}
}
