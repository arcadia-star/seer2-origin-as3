package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1548 {


    public var eventType:uint;

    public var eventDataVec:Vector.<uint>;

    public function Parser_1548(param1:IDataInput) {
        super();
        this.eventType = param1.readUnsignedInt();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        this.eventDataVec = new Vector.<uint>();
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            this.eventDataVec.push(param1.readUnsignedInt());
            _loc3_++;
        }
    }
}
}
