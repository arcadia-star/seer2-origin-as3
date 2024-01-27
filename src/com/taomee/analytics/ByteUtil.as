package com.taomee.analytics {
import flash.utils.ByteArray;

internal class ByteUtil {


    public function ByteUtil() {
        super();
    }

    public static function toString(param1:ByteArray):String {
        var _loc4_:String = null;
        var _loc2_:String = "";
        var _loc3_:uint = param1.position;
        param1.position = 0;
        while (param1.bytesAvailable) {
            _loc4_ = param1.readUnsignedByte().toString(16);
            _loc2_ += _loc4_.length == 1 ? "0" + _loc4_ : _loc4_;
        }
        param1.position = _loc3_;
        return _loc2_;
    }
}
}
