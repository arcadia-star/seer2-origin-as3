package com.taomee.seer2.core.utils {
public class NumberUtil {


    public function NumberUtil() {
        super();
    }

    public static function parseNumberToDigitVec(param1:int):Vector.<int> {
        var _loc4_:int = 0;
        var _loc2_:Vector.<int> = new Vector.<int>();
        var _loc3_:int = 0;
        if (param1 > 0) {
            while (param1 > 0) {
                _loc4_ = param1 % 10;
                _loc2_.push(_loc4_);
                param1 /= 10;
                _loc3_++;
            }
        } else if (param1 == 0) {
            _loc2_.push(0);
        }
        return _loc2_.reverse();
    }

    public static function getRandomInt(param1:int):int {
        return int(-(param1 >> 1) + Math.random() * (param1 >> 1));
    }

    public static function equalsNumber(param1:Number, param2:Number):Boolean {
        var _loc3_:Number = 0.01;
        if (Math.abs(param1 - param2) < _loc3_) {
            return true;
        }
        return false;
    }

    public static function random(param1:Number, param2:Number = 0, param3:Number = 1):Number {
        var _loc6_:Number = NaN;
        if (param1 > param2) {
            _loc6_ = param1;
            param1 = param2;
            param2 = _loc6_;
        }
        var _loc4_:Number = param2 - param1 + 1 * param3;
        var _loc5_:Number = (_loc5_ = Math.random() * _loc4_) + param1;
        return floor(_loc5_, param3);
    }

    public static function randomArrFromArr(param1:Array, param2:int):Array {
        if (param1 == null || param1.length < param2) {
            return null;
        }
        var _loc3_:Array = new Array();
        var _loc4_:Array = randomArr(0, param1.length - 1, param2);
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_.length) {
            _loc3_.push(param1[_loc4_[_loc5_]]);
            _loc5_++;
        }
        return _loc3_;
    }

    public static function randomArr(param1:Number, param2:Number, param3:int, param4:Number = 1):Array {
        var _loc6_:int = 0;
        var _loc5_:Array = new Array();
        while (_loc5_.length < param3) {
            _loc6_ = random(param1, param2, param4);
            if (!isNumInArr(_loc6_, _loc5_)) {
                _loc5_.push(_loc6_);
            }
        }
        return _loc5_;
    }

    public static function isNumInArr(param1:int, param2:Array):Boolean {
        var _loc3_:int = 0;
        while (_loc3_ < param2.length) {
            if (param1 == param2[_loc3_]) {
                return true;
            }
            _loc3_++;
        }
        return false;
    }

    public static function floor(param1:Number, param2:Number = 1):Number {
        return Math.floor(param1 / param2) * param2;
    }

    public static function numInRange(param1:Number, param2:Number, param3:Number):int {
        if (param1 == param2) {
            return 1;
        }
        if (param1 == param3) {
            return 2;
        }
        if (param1 < param2 || param1 > param3) {
            return 0;
        }
        return 3;
    }
}
}
