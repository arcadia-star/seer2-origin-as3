package com.taomee.analytics {
internal class BitUtil {


    public function BitUtil() {
        super();
    }

    public static function getBitBool(param1:int, param2:int):Boolean {
        if (param2 <= 0) {
            throw "指定位必须大于0.";
        }
        param2--;
        param1 >>= param2;
        return Boolean(param1 & 1);
    }

    public static function setBitBool(param1:int, param2:int, param3:Boolean):int {
        if (param2 <= 0) {
            throw "指定位必须大于0.";
        }
        var _loc4_:Boolean = getBitBool(param1, param2);
        param2--;
        if (_loc4_ == param3) {
            return param1;
        }
        if (_loc4_) {
            return param1 - Math.pow(2, param2);
        }
        return param1 + Math.pow(2, param2);
    }
}
}
