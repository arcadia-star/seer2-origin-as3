package com.taomee.seer2.app.arena.record {
public class UUID {

    private static var _aUniqueIDs:Array;


    public function UUID() {
        super();
    }

    public static function floor(param1:Number, param2:Number = 1):Number {
        return Math.floor(param1 / param2) * param2;
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

    public static function getUnique():Number {
        if (_aUniqueIDs == null) {
            _aUniqueIDs = new Array();
        }
        var _loc1_:Date = new Date();
        var _loc2_:Number = _loc1_.getTime();
        while (!isUnique(_loc2_)) {
            _loc2_ += UUID.random(_loc1_.getTime(), 2 * _loc1_.getTime());
        }
        _aUniqueIDs.push(_loc2_);
        return _loc2_;
    }

    private static function isUnique(param1:Number):Boolean {
        var _loc2_:Number = 0;
        while (_loc2_ < _aUniqueIDs.length) {
            if (_aUniqueIDs[_loc2_] == param1) {
                return false;
            }
            _loc2_++;
        }
        return true;
    }
}
}
