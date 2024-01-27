package com.taomee.seer2.core.map.grids {
import flash.geom.Point;

public class Diagonal {


    public function Diagonal() {
        super();
    }

    public static function each(param1:Point, param2:Point):Array {
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc8_:Number = NaN;
        var _loc9_:Number = NaN;
        var _loc10_:Number = NaN;
        var _loc11_:Boolean = false;
        var _loc12_:Boolean = false;
        var _loc13_:int = 0;
        var _loc7_:Array = [];
        var _loc14_:int = 0;
        var _loc15_:* = param1.x < param2.x == param1.y < param2.y;
        if (param1.x < param2.x) {
            _loc5_ = param1.x;
            _loc6_ = param1.y;
            _loc3_ = param2.x - _loc5_;
            _loc4_ = Math.abs(param2.y - _loc6_);
        } else {
            _loc5_ = param2.x;
            _loc6_ = param2.y;
            _loc3_ = param1.x - _loc5_;
            _loc4_ = Math.abs(param1.y - _loc6_);
        }
        if (_loc3_ == _loc4_) {
            _loc13_ = 0;
            while (_loc13_ <= _loc3_) {
                if (_loc15_) {
                    _loc7_.push(new Point(_loc5_ + _loc13_, _loc6_ + _loc13_));
                } else {
                    _loc7_.push(new Point(_loc5_ + _loc13_, _loc6_ - _loc13_));
                }
                if (_loc13_ > 0) {
                    if (_loc15_) {
                        _loc7_.push(new Point(_loc5_ + _loc13_ - 1, _loc6_ + _loc13_));
                    } else {
                        _loc7_.push(new Point(_loc5_ + _loc13_ - 1, _loc6_ - _loc13_));
                    }
                }
                if (_loc13_ < _loc3_) {
                    if (_loc15_) {
                        _loc7_.push(new Point(_loc5_ + _loc13_ + 1, _loc6_ + _loc13_));
                    } else {
                        _loc7_.push(new Point(_loc5_ + _loc13_ + 1, _loc6_ - _loc13_));
                    }
                }
                _loc13_++;
            }
        } else if (_loc3_ > _loc4_) {
            _loc8_ = _loc4_ / _loc3_;
            _loc7_.push(new Point(_loc5_, _loc6_));
            _loc13_ = 1;
            while (_loc13_ <= _loc3_) {
                _loc9_ = (_loc13_ - 0.5) * _loc8_;
                _loc10_ = (_loc13_ + 0.5) * _loc8_;
                _loc11_ = _loc9_ > _loc14_ - 0.5 && _loc9_ < _loc14_ + 0.5;
                _loc12_ = _loc10_ > _loc14_ - 0.5 && _loc10_ < _loc14_ + 0.5;
                if (_loc11_ || _loc12_) {
                    if (_loc15_) {
                        _loc7_.push(new Point(_loc5_ + _loc13_, _loc6_ + _loc14_));
                    } else {
                        _loc7_.push(new Point(_loc5_ + _loc13_, _loc6_ - _loc14_));
                    }
                    if (!_loc12_) {
                        _loc14_++;
                        if (_loc15_) {
                            _loc7_.push(new Point(_loc5_ + _loc13_, _loc6_ + _loc14_));
                        } else {
                            _loc7_.push(new Point(_loc5_ + _loc13_, _loc6_ - _loc14_));
                        }
                    }
                }
                _loc13_++;
            }
        } else if (_loc3_ < _loc4_) {
            _loc8_ = _loc3_ / _loc4_;
            _loc7_.push(new Point(_loc5_, _loc6_));
            _loc13_ = 1;
            while (_loc13_ <= _loc4_) {
                _loc9_ = (_loc13_ - 0.5) * _loc8_;
                _loc10_ = (_loc13_ + 0.5) * _loc8_;
                _loc11_ = _loc9_ > _loc14_ - 0.5 && _loc9_ < _loc14_ + 0.5;
                _loc12_ = _loc10_ > _loc14_ - 0.5 && _loc10_ < _loc14_ + 0.5;
                if (_loc11_ || _loc12_) {
                    if (_loc15_) {
                        _loc7_.push(new Point(_loc5_ + _loc14_, _loc6_ + _loc13_));
                    } else {
                        _loc7_.push(new Point(_loc5_ + _loc14_, _loc6_ - _loc13_));
                    }
                    if (!_loc12_) {
                        _loc14_++;
                        if (_loc15_) {
                            _loc7_.push(new Point(_loc5_ + _loc14_, _loc6_ + _loc13_));
                        } else {
                            _loc7_.push(new Point(_loc5_ + _loc14_, _loc6_ - _loc13_));
                        }
                    }
                }
                _loc13_++;
            }
        }
        return _loc7_;
    }
}
}
