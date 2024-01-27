package org.taomee.algo {
import flash.geom.Point;

public class AStar {

    private static const COST_STRAIGHT:int = 10;

    private static var _instance:AStar;

    public static const arounds:Array = [new Point(1, 0), new Point(0, 1), new Point(-1, 0), new Point(0, -1), new Point(1, 1), new Point(-1, 1), new Point(-1, -1), new Point(1, -1)];

    private static const COST_DIAGONAL:int = 14;


    private var _fatherList:Array;

    private const NOTE_OPEN:int = 1;

    private const NOTE_ID:int = 0;

    private var _noteMap:Array;

    private var _mapModel:IMapModel;

    private var _isOptimize:Boolean = true;

    private const NOTE_CLOSED:int = 2;

    private var _openId:int;

    private var _nodeList:Array;

    private var _openCount:int;

    private var _openList:Array;

    private var _pathScoreList:Array;

    public var maxTry:int = 1000;

    private var _movementCostList:Array;

    public function AStar() {
        super();
    }

    public static function get instance():AStar {
        if (_instance == null) {
            _instance = new AStar();
        }
        return _instance;
    }

    public function find(param1:Point, param2:Point, param3:Boolean = true):Array {
        var _loc7_:int = 0;
        var _loc8_:Point = null;
        var _loc9_:int = 0;
        var _loc10_:int = 0;
        var _loc11_:int = 0;
        var _loc12_:Array = null;
        var _loc13_:Point = null;
        if (_mapModel == null) {
            return null;
        }
        var _loc4_:Point = transPoint(param1.clone());
        var _loc5_:Point = transPoint(param2.clone());
        if (!isArrive(_loc5_)) {
            return null;
        }
        _isOptimize = param3;
        initLists();
        _openCount = 0;
        _openId = -1;
        openNote(_loc4_, 0, 0, 0);
        var _loc6_:int = 0;
        while (_openCount > 0) {
            if (++_loc6_ > maxTry) {
                destroyLists();
                return null;
            }
            _loc7_ = int(_openList[0]);
            closeNote(_loc7_);
            _loc8_ = _nodeList[_loc7_];
            if (_loc5_.equals(_loc8_)) {
                return getPath(_loc4_, _loc7_);
            }
            _loc12_ = getArounds(_loc8_);
            for each(_loc13_ in _loc12_) {
                _loc11_ = (_loc10_ = _movementCostList[_loc7_] + (_loc13_.x == _loc8_.x || _loc13_.y == _loc8_.y ? COST_STRAIGHT : COST_DIAGONAL)) + (Math.abs(_loc5_.x - _loc13_.x) + Math.abs(_loc5_.y - _loc13_.y)) * COST_STRAIGHT;
                if (isOpen(_loc13_)) {
                    _loc9_ = int(_noteMap[_loc13_.y][_loc13_.x][NOTE_ID]);
                    if (_loc10_ < _movementCostList[_loc9_]) {
                        _movementCostList[_loc9_] = _loc10_;
                        _pathScoreList[_loc9_] = _loc11_;
                        _fatherList[_loc9_] = _loc7_;
                        aheadNote(_openList.indexOf(_loc9_) + 1);
                    }
                } else {
                    openNote(_loc13_, _loc11_, _loc10_, _loc7_);
                }
            }
        }
        destroyLists();
        return null;
    }

    private function isOpen(param1:Point):Boolean {
        if (_noteMap[param1.y] == null) {
            return false;
        }
        if (_noteMap[param1.y][param1.x] == null) {
            return false;
        }
        return _noteMap[param1.y][param1.x][NOTE_OPEN];
    }

    public function init(param1:IMapModel):void {
        _mapModel = param1;
    }

    private function aheadNote(param1:int):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        while (param1 > 1) {
            _loc2_ = int(param1 / 2);
            if (getScore(param1) >= getScore(_loc2_)) {
                break;
            }
            _loc3_ = int(_openList[param1 - 1]);
            _openList[param1 - 1] = _openList[_loc2_ - 1];
            _openList[_loc2_ - 1] = _loc3_;
            param1 = _loc2_;
        }
    }

    private function openNote(param1:Point, param2:int, param3:int, param4:int):void {
        ++_openCount;
        ++_openId;
        if (_noteMap[param1.y] == null) {
            _noteMap[param1.y] = [];
        }
        _noteMap[param1.y][param1.x] = [];
        _noteMap[param1.y][param1.x][NOTE_OPEN] = true;
        _noteMap[param1.y][param1.x][NOTE_ID] = _openId;
        _nodeList.push(param1);
        _pathScoreList.push(param2);
        _movementCostList.push(param3);
        _fatherList.push(param4);
        _openList.push(_openId);
        aheadNote(_openCount);
    }

    private function optimize(param1:Array, param2:int = 0):void {
        var _loc5_:Point = null;
        var _loc6_:int = 0;
        var _loc7_:Number = NaN;
        var _loc10_:int = 0;
        var _loc11_:int = 0;
        var _loc12_:Point = null;
        if (param1 == null) {
            return;
        }
        var _loc3_:int = int(param1.length - 1);
        if (_loc3_ < 2) {
            return;
        }
        var _loc4_:Point = param1[param2];
        var _loc8_:Array = [];
        var _loc9_:int = _loc3_;
        while (_loc9_ > param2) {
            _loc5_ = param1[_loc9_];
            _loc6_ = Point.distance(_loc4_, _loc5_);
            _loc7_ = Math.atan2(_loc5_.y - _loc4_.y, _loc5_.x - _loc4_.x);
            _loc10_ = 1;
            while (_loc10_ < _loc6_) {
                (_loc12_ = _loc4_.add(Point.polar(_loc10_, _loc7_))).x = int(_loc12_.x);
                _loc12_.y = int(_loc12_.y);
                if (!_mapModel.data[_loc12_.x][_loc12_.y]) {
                    _loc8_.length = 0;
                    break;
                }
                _loc8_.push(_loc12_);
                _loc10_++;
            }
            if ((_loc11_ = int(_loc8_.length)) > 0) {
                param1.splice(param2 + 1, _loc9_ - param2 - 1);
                param2 += _loc11_ - 1;
                break;
            }
            _loc9_--;
        }
        if (param2 < _loc3_) {
            optimize(param1, ++param2);
        }
    }

    private function transPoint(param1:Point):Point {
        param1.x = int(param1.x / _mapModel.gridSize);
        param1.y = int(param1.y / _mapModel.gridSize);
        return param1;
    }

    private function isArrive(param1:Point):Boolean {
        if (param1.x < 0 || param1.x >= _mapModel.gridX || param1.y < 0 || param1.y >= _mapModel.gridY) {
            return false;
        }
        return _mapModel.data[param1.x][param1.y];
    }

    private function closeNote(param1:int):void {
        --_openCount;
        var _loc2_:Point = _nodeList[param1];
        _noteMap[_loc2_.y][_loc2_.x][NOTE_OPEN] = false;
        _noteMap[_loc2_.y][_loc2_.x][NOTE_CLOSED] = true;
        if (_openCount <= 0) {
            _openCount = 0;
            _openList.length = 0;
            return;
        }
        _openList[0] = _openList.pop();
        backNote();
    }

    private function getScore(param1:int):int {
        return _pathScoreList[_openList[param1 - 1]];
    }

    private function getArounds(param1:Point):Array {
        var _loc3_:Point = null;
        var _loc4_:Boolean = false;
        var _loc2_:Array = [];
        var _loc5_:int = 0;
        _loc3_ = param1.add(arounds[_loc5_]);
        _loc5_++;
        var _loc6_:Boolean;
        if ((_loc6_ = isArrive(_loc3_)) && !isClosed(_loc3_)) {
            _loc2_.push(_loc3_);
        }
        _loc3_ = param1.add(arounds[_loc5_]);
        _loc5_++;
        var _loc7_:Boolean;
        if ((_loc7_ = isArrive(_loc3_)) && !isClosed(_loc3_)) {
            _loc2_.push(_loc3_);
        }
        _loc3_ = param1.add(arounds[_loc5_]);
        _loc5_++;
        var _loc8_:Boolean;
        if ((_loc8_ = isArrive(_loc3_)) && !isClosed(_loc3_)) {
            _loc2_.push(_loc3_);
        }
        _loc3_ = param1.add(arounds[_loc5_]);
        _loc5_++;
        var _loc9_:Boolean;
        if ((_loc9_ = isArrive(_loc3_)) && !isClosed(_loc3_)) {
            _loc2_.push(_loc3_);
        }
        _loc3_ = param1.add(arounds[_loc5_]);
        _loc5_++;
        if ((_loc4_ = isArrive(_loc3_)) && _loc6_ && _loc7_ && !isClosed(_loc3_)) {
            _loc2_.push(_loc3_);
        }
        _loc3_ = param1.add(arounds[_loc5_]);
        _loc5_++;
        if ((_loc4_ = isArrive(_loc3_)) && _loc8_ && _loc7_ && !isClosed(_loc3_)) {
            _loc2_.push(_loc3_);
        }
        _loc3_ = param1.add(arounds[_loc5_]);
        _loc5_++;
        if ((_loc4_ = isArrive(_loc3_)) && _loc8_ && _loc9_ && !isClosed(_loc3_)) {
            _loc2_.push(_loc3_);
        }
        _loc3_ = param1.add(arounds[_loc5_]);
        _loc5_++;
        if ((_loc4_ = isArrive(_loc3_)) && _loc6_ && _loc9_ && !isClosed(_loc3_)) {
            _loc2_.push(_loc3_);
        }
        return _loc2_;
    }

    private function getPath(param1:Point, param2:int):Array {
        var _loc3_:Array = [];
        var _loc4_:Point = _nodeList[param2];
        while (!param1.equals(_loc4_)) {
            _loc3_.push(_loc4_);
            param2 = int(_fatherList[param2]);
            _loc4_ = _nodeList[param2];
        }
        _loc3_.push(param1);
        destroyLists();
        _loc3_.reverse();
        if (_isOptimize) {
            optimize(_loc3_);
        }
        _loc3_.forEach(eachArray);
        return _loc3_;
    }

    private function eachArray(param1:Point, param2:int, param3:Array):void {
        param1.x *= _mapModel.gridSize;
        param1.y *= _mapModel.gridSize;
    }

    private function initLists():void {
        _openList = [];
        _nodeList = [];
        _pathScoreList = [];
        _movementCostList = [];
        _fatherList = [];
        _noteMap = [];
    }

    private function isClosed(param1:Point):Boolean {
        if (_noteMap[param1.y] == null) {
            return false;
        }
        if (_noteMap[param1.y][param1.x] == null) {
            return false;
        }
        return _noteMap[param1.y][param1.x][NOTE_CLOSED];
    }

    private function destroyLists():void {
        _openList = null;
        _nodeList = null;
        _pathScoreList = null;
        _movementCostList = null;
        _fatherList = null;
        _noteMap = null;
    }

    private function backNote():void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc1_:int = 1;
        while (true) {
            _loc2_ = _loc1_;
            if (2 * _loc2_ <= _openCount) {
                if (getScore(_loc1_) > getScore(2 * _loc2_)) {
                    _loc1_ = 2 * _loc2_;
                }
                if (2 * _loc2_ + 1 <= _openCount) {
                    if (getScore(_loc1_) > getScore(2 * _loc2_ + 1)) {
                        _loc1_ = 2 * _loc2_ + 1;
                    }
                }
            }
            if (_loc2_ == _loc1_) {
                break;
            }
            _loc3_ = int(_openList[_loc2_ - 1]);
            _openList[_loc2_ - 1] = _openList[_loc1_ - 1];
            _openList[_loc1_ - 1] = _loc3_;
        }
    }
}
}
