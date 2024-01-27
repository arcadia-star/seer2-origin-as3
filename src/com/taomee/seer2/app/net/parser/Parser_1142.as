package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1142 {


    public var infoVec:Vector.<uint>;

    private var _ids:Array;

    public function Parser_1142(param1:IDataInput) {
        super();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        this.infoVec = new Vector.<uint>();
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            this.infoVec.push(param1.readUnsignedInt());
            _loc3_++;
        }
    }
}
}
