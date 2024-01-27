package com.taomee.seer2.core.utils {
public class ArrayUtil {


    public function ArrayUtil() {
        super();
    }

    public static function randomArray(param1:Array):Array {
        var _loc2_:Array = [];
        while (param1.length > 0) {
            _loc2_.push(param1.splice(Math.floor(Math.random() * param1.length), 1)[0]);
        }
        return _loc2_;
    }

    public static function toArray(param1:*):Array {
        var _loc2_:int = int(param1.length);
        var _loc3_:Array = [];
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_) {
            _loc3_.push(param1[_loc4_]);
            _loc4_++;
        }
        return _loc3_;
    }

    public static function getContainsNumber(param1:Array, param2:*):int {
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            if (param1[_loc4_] == param2) {
                _loc3_++;
            }
            _loc4_++;
        }
        return _loc3_;
    }
}
}
