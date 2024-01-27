package com.taomee.seer2.core.utils.effect {
import flash.display.DisplayObject;
import flash.utils.Dictionary;

public class EffectShake {

    public static var _shake:Array = [];

    private static var randomHistory:Dictionary = new Dictionary();


    public function EffectShake() {
        super();
    }

    public static function update():void {
        var _loc1_:Number = NaN;
        if (_shake.length > 0) {
            _loc1_ = _shake.length - 1;
            while (_loc1_ >= 0) {
                shake(_loc1_);
                _loc1_--;
            }
        }
    }

    public static function addShake(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number = NaN, param6:Boolean = false):void {
        var _loc7_:Number = NaN;
        if (null != param1) {
            _loc7_ = arrayIndex(_shake, param1, 0);
            if (-1 == _loc7_) {
                _shake.push([param1, [param2, param3, param4, param5], [param1.x, param1.y]]);
            } else if (param6) {
                _shake[_loc7_].push([param2, param3, param4, param5], [param1.x, param1.y]);
            } else if (_shake[_loc7_][1][0] + _shake[_loc7_][1][1] <= param2 + param3) {
                _shake[_loc7_][1] = [param2, param3, param4, param5];
            }
        }
    }

    private static function removeIndex(param1:Number):void {
        _shake[param1][0].x = _shake[param1][2][0];
        _shake[param1][0].y = _shake[param1][2][1];
        _shake.splice(param1, 1);
    }

    private static function shake(param1:Number):void {
        var _loc6_:Boolean = false;
        var _loc2_:Array = _shake[param1];
        var _loc3_:DisplayObject = _loc2_[0];
        var _loc4_:Array = _loc2_[1];
        var _loc5_:Array = _loc2_[2];
        if (!isNaN(_loc4_[2]) && _loc4_[2] > 0) {
            if (_loc3_.x != _loc5_[0]) {
                _loc3_.x = _loc5_[0];
            } else {
                _loc3_.x = dec(-1, 1) * _loc4_[0] + _loc5_[0];
            }
            --_loc4_[2];
            _loc6_ = true;
        }
        if (!isNaN(_loc4_[3]) && _loc4_[3] > 0) {
            if (_loc3_.y != _loc5_[1]) {
                _loc3_.y = _loc5_[1];
            } else {
                _loc3_.y = dec(-1, 1) * _loc4_[1] + _loc5_[1];
            }
            --_loc4_[3];
            _loc6_ = true;
        }
        if (!_loc6_) {
            removeIndex(param1);
        }
    }

    public static function deleteShake(param1:DisplayObject):void {
        var _loc2_:uint = 0;
        while (_loc2_ < _shake.length) {
            if (_shake[_loc2_][0] == param1) {
                removeIndex(_loc2_);
                break;
            }
            _loc2_++;
        }
    }

    public static function arrayIndex(param1:Array, param2:DisplayObject, param3:uint):Number {
        var _loc4_:int = -1;
        var _loc5_:uint = 0;
        while (_loc5_ < param1.length) {
            if (param1[_loc5_][param3] == param2) {
                _loc4_ = int(_loc5_);
                break;
            }
            _loc5_++;
        }
        return _loc4_;
    }

    public static function dec(param1:Number, param2:Number, param3:Boolean = true):Number {
        var _loc4_:Number = NaN;
        _loc4_ = param1 + Math.random() * (param2 - param1);
        if (!param3) {
            while (randomHistory[_loc4_]) {
                _loc4_ = param1 + Math.random() * (param2 - param1);
            }
            randomHistory[_loc4_] = true;
        }
        return _loc4_;
    }
}
}
