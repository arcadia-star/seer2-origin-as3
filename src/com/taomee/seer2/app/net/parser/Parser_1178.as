package com.taomee.seer2.app.net.parser {
import com.taomee.seer2.app.net.parser.baseData.ItemSwapInfo;

import flash.utils.IDataInput;

public class Parser_1178 {


    public var cmd:uint;

    public var itemVec:Vector.<ItemSwapInfo>;

    public function Parser_1178(param1:IDataInput) {
        var _loc4_:ItemSwapInfo = null;
        super();
        this.cmd = param1.readUnsignedInt();
        this.itemVec = new Vector.<ItemSwapInfo>();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = new ItemSwapInfo(param1);
            this.itemVec.push(_loc4_);
            _loc3_++;
        }
    }
}
}
