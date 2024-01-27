package com.taomee.seer2.core.map.grids {
import flash.geom.Point;

public class RoadSeeker {


    private var _map:Array;

    private var _w:int;

    private var _h:int;

    private var _open:Array;

    private var _aveOpen:Number;

    private var _starPoint:Object;

    private var _endPoint:Object;

    private var _autoOptimize:Boolean;

    private var _cellWidth:Number;

    private var _cellHeight:Number;

    public var path:Array;

    private var _directEndPoint:Point;

    private var _directRow:int;

    private var _pMap:Array;

    public function RoadSeeker(param1:Array, param2:Number, param3:Number, param4:Boolean = true) {
        var _loc6_:int = 0;
        this.path = [];
        super();
        this._map = [];
        this._w = param1[0].length;
        this._h = param1.length;
        this._cellWidth = param2;
        this._cellHeight = param3;
        this._pMap = param1;
        this._autoOptimize = param4;
        var _loc5_:int = 0;
        while (_loc5_ < this._h) {
            if (this._map[_loc5_] == undefined) {
                this._map[_loc5_] = [];
            }
            _loc6_ = 0;
            while (_loc6_ < this._w) {
                this._map[_loc5_][_loc6_] = {
                    "px": param1[_loc5_][_loc6_].px,
                    "py": param1[_loc5_][_loc6_].py,
                    "x": _loc6_,
                    "y": _loc5_,
                    "value": param1[_loc5_][_loc6_].value,
                    "block": false,
                    "open": false,
                    "value_g": 0,
                    "value_h": 0,
                    "value_f": 0,
                    "nodeparent": null,
                    "index": -1
                };
                _loc6_++;
            }
            _loc5_++;
        }
    }

    public function path8(param1:Point, param2:Point):Array {
        var _loc5_:Array = null;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc8_:Object = null;
        this.path = [];
        this._starPoint = this._map[param1.y][param1.x];
        this._endPoint = this._map[param2.y][param2.x];
        var _loc3_:Boolean = false;
        this.initBlock();
        var _loc4_:Object = this._starPoint;
        while (true) {
            if (_loc3_) {
                this.drawPath();
                if (this._autoOptimize) {
                    this.optimizePath();
                }
                return this.path;
            }
            _loc4_.block = true;
            _loc5_ = [];
            if (_loc4_.x > 0 && _loc4_.y > 0) {
                _loc5_.push(this._map[_loc4_.y - 1][_loc4_.x - 1]);
            }
            if (_loc4_.y > 0) {
                _loc5_.push(this._map[_loc4_.y - 1][_loc4_.x]);
            }
            if (_loc4_.x < this._w - 1 && _loc4_.y > 0) {
                _loc5_.push(this._map[_loc4_.y - 1][_loc4_.x + 1]);
            }
            if (_loc4_.x > 0) {
                _loc5_.push(this._map[_loc4_.y][_loc4_.x - 1]);
            }
            if (_loc4_.x < this._w - 1) {
                _loc5_.push(this._map[_loc4_.y][_loc4_.x + 1]);
            }
            if (_loc4_.x > 0 && _loc4_.y < this._h - 1) {
                _loc5_.push(this._map[_loc4_.y + 1][_loc4_.x - 1]);
            }
            if (_loc4_.y < this._h - 1) {
                _loc5_.push(this._map[_loc4_.y + 1][_loc4_.x]);
            }
            if (_loc4_.x < this._w - 1 && _loc4_.y < this._h - 1) {
                _loc5_.push(this._map[_loc4_.y + 1][_loc4_.x + 1]);
            }
            _loc6_ = int(_loc5_.length);
            _loc7_ = 0;
            while (_loc7_ < _loc6_) {
                _loc8_ = _loc5_[_loc7_];
                if (this._map[_loc8_.y][_loc4_.x].value == 0 && this._map[_loc4_.y][_loc8_.x].value == 0) {
                    if (_loc8_ == this._endPoint) {
                        _loc8_.nodeparent = _loc4_;
                        _loc3_ = true;
                        break;
                    }
                    if (_loc8_.x == _loc4_.x || _loc8_.y == _loc4_.y) {
                        this.count(_loc8_, _loc4_);
                    } else if (_loc8_.value == 0) {
                        this.count(_loc8_, _loc4_, true);
                    }
                }
                _loc7_++;
            }
            if (!_loc3_) {
                if (this._open.length <= 0) {
                    break;
                }
                _loc4_ = this.getOpen();
            }
        }
        return [];
    }

    private function optimizePath():Array {
        var _loc4_:int = 0;
        var _loc8_:int = 0;
        if (this.path.length == 0) {
            return [];
        }
        var _loc1_:int = int(this.path.length);
        var _loc2_:Array = [];
        var _loc3_:Array = [];
        var _loc5_:Boolean = true;
        var _loc6_:Point = this.path[0];
        _loc2_.push(this.path[0]);
        var _loc7_:int = 1;
        while (_loc7_ < _loc1_) {
            _loc3_ = Diagonal.each(_loc6_, this.path[_loc7_]);
            _loc4_ = int(_loc3_.length);
            _loc5_ = true;
            _loc8_ = 0;
            while (_loc8_ < _loc4_) {
                if (this._map[_loc3_[_loc8_].y][_loc3_[_loc8_].x].value == 1) {
                    _loc5_ = false;
                    break;
                }
                _loc8_++;
            }
            if (!_loc5_) {
                if (_loc7_ > 1) {
                    _loc6_ = this.path[_loc7_ - 1];
                    _loc2_.push(this.path[_loc7_ - 1]);
                }
            }
            _loc7_++;
        }
        _loc2_.push(this.path[_loc1_ - 1]);
        this.path = _loc2_.concat();
        return this.path;
    }

    private function convertPath(param1:Array):void {
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            _loc2_++;
        }
    }

    public function set autoOptimize(param1:Boolean):void {
        this._autoOptimize = param1;
    }

    public function get autoOptimize():Boolean {
        return this._autoOptimize;
    }

    private function initBlock():void {
        var _loc2_:int = 0;
        var _loc1_:int = 0;
        while (_loc1_ < this._h) {
            _loc2_ = 0;
            while (_loc2_ < this._w) {
                this._map[_loc1_][_loc2_].open = false;
                this._map[_loc1_][_loc2_].block = false;
                this._map[_loc1_][_loc2_].value_g = 0;
                this._map[_loc1_][_loc2_].value_h = 0;
                this._map[_loc1_][_loc2_].value_f = 0;
                this._map[_loc1_][_loc2_].nodeparent = null;
                this._map[_loc1_][_loc2_].index = -1;
                this._map[_loc1_][_loc2_].px = this._pMap[_loc1_][_loc2_].px;
                this._map[_loc1_][_loc2_].py = this._pMap[_loc1_][_loc2_].py;
                this._map[_loc1_][_loc2_].value = this._pMap[_loc1_][_loc2_].value;
                _loc2_++;
            }
            _loc1_++;
        }
        this._open = [];
        this._aveOpen = 0;
    }

    private function count(param1:Object, param2:Object, param3:Boolean = false):void {
        var _loc4_:Number = NaN;
        var _loc5_:int = 0;
        if (!param1.block) {
            _loc4_ = param3 ? param2.value_g + 14 : param2.value_g + 10;
            if (param1.open) {
                if (param1.value_g >= _loc4_) {
                    this._aveOpen += (this._aveOpen - param1.value_f) / this._open.length;
                    _loc5_ = this._open.indexOf(param1);
                    this._open.splice(_loc5_, 1);
                    param1.value_g = _loc4_;
                    this.ghf(param1);
                    param1.nodeparent = param2;
                    this.setOpen(param1);
                }
            } else {
                param1.value_g = _loc4_;
                this.ghf(param1);
                param1.nodeparent = param2;
                this.setOpen(param1);
            }
        }
    }

    private function drawPath():void {
        var _loc1_:Object = this._endPoint;
        while (_loc1_ != this._starPoint) {
            this.path.unshift(new Point(_loc1_.x, _loc1_.y));
            _loc1_ = _loc1_.nodeparent;
        }
        this.path.unshift(new Point(_loc1_.x, _loc1_.y));
    }

    private function ghf(param1:Object):void {
        var _loc2_:Number = Math.abs(param1.x - this._endPoint.x);
        var _loc3_:Number = Math.abs(param1.y - this._endPoint.y);
        param1.value_h = 10 * (_loc2_ + _loc3_);
        param1.value_f = param1.value_g + param1.value_h;
    }

    private function setOpen(param1:Object):void {
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        param1.open = true;
        var _loc2_:int = int(this._open.length);
        if (_loc2_ == 0) {
            this._open.push(param1);
            this._aveOpen = param1.value_f;
        } else {
            if (param1.value_f < this._aveOpen) {
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    if (param1.value_f <= this._open[_loc3_].value_f) {
                        this._open.splice(_loc3_, 0, param1);
                        break;
                    }
                    _loc3_++;
                }
            } else {
                _loc4_ = _loc2_;
                while (_loc4_ > 0) {
                    if (param1.value_f >= this._open[_loc4_ - 1].value_f) {
                        this._open.splice(_loc4_, 0, param1);
                        break;
                    }
                    _loc4_--;
                }
            }
            this._aveOpen += (param1.value_f - this._aveOpen) / this._open.length;
        }
    }

    private function getOpen():Object {
        var _loc1_:Object = this._open.splice(0, 1)[0];
        this._aveOpen += (this._aveOpen - _loc1_.value_f) / this._open.length;
        return _loc1_;
    }

    private function getMin():int {
        var _loc1_:int = int(this._open.length);
        var _loc2_:Number = Number(this._open[0].value_f);
        var _loc3_:int = 0;
        var _loc4_:int = 1;
        while (_loc4_ < _loc1_) {
            if (_loc2_ > this._open[_loc4_].value_f) {
                _loc2_ = Number(this._open[_loc4_].value_f);
                _loc3_ = _loc4_;
            }
            _loc4_++;
        }
        return _loc3_;
    }

    public function value(param1:int, param2:int):int {
        return this._map[param2][param1].value;
    }
}
}
