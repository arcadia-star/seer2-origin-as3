package com.taomee.seer2.core.map.grids {
import flash.display.Shape;
import flash.geom.Point;

public class RoadPointLayer extends BaseDisplayObject {


    private var _cellWidth:Number;

    private var _cellHeight:Number;

    private var _childMap:HashMap;

    private var _map:GameMap;

    public function RoadPointLayer(param1:GameMap) {
        super();
        this._map = param1;
        this._cellWidth = param1.cellWidth;
        this._cellHeight = param1.cellHeight;
        this._childMap = new HashMap();
    }

    public function drawCell(param1:int, param2:int, param3:int):void {
        var _loc4_:Number = NaN;
        if (param3 == HetapFishGameConstant.MAPEDITOR_CELL_TYPE_ROAD) {
            _loc4_ = 3407667;
        } else {
            if (param3 != HetapFishGameConstant.MAPEDITOR_CELL_TYPE_HINDER) {
                throw new Error("未知单元格类型！");
            }
            _loc4_ = 16711731;
        }
        var _loc5_:Point = GameMapUtils.getPixelPoint(this._cellWidth, this._cellHeight, param1, param2);
        this.resetCell(param1, param2);
        var _loc6_:Shape;
        (_loc6_ = new Shape()).graphics.beginFill(_loc4_, 0.5);
        _loc6_.graphics.drawCircle(0, 0, this._cellHeight / 4);
        _loc6_.graphics.endFill();
        _loc6_.x = _loc5_.x;
        _loc6_.y = _loc5_.y;
        addChild(_loc6_);
        var _loc7_:String = param1 + "," + param2;
        this._childMap.put(_loc7_, _loc6_);
    }

    public function resetCell(param1:int, param2:int):void {
        var _loc3_:String = param1 + "," + param2;
        var _loc4_:*;
        if ((_loc4_ = this._childMap.getValue(_loc3_)) != null && _loc4_.parent == this) {
            removeChild(_loc4_);
        }
    }

    public function drawWalkableBuilding(param1:GameMapItem, param2:int, param3:int, param4:Boolean):void {
        var _loc11_:int = 0;
        var _loc12_:int = 0;
        var _loc14_:Point = null;
        var _loc15_:* = undefined;
        var _loc6_:Array;
        var _loc5_:String;
        if ((_loc6_ = (_loc5_ = param1.configXml.walkable).split(",")) == null || _loc6_.length < 2) {
            return;
        }
        var _loc7_:Number = this._map.cellWidth;
        var _loc8_:Number = this._map.cellHeight;
        var _loc9_:int = this._map.mapHeight / _loc8_;
        var _loc10_:int = this._map.mapWidth / _loc7_;
        var _loc13_:int = 0;
        while (_loc13_ < _loc6_.length) {
            _loc12_ = param3 + int(_loc6_[_loc13_ + 1]);
            _loc11_ = param2 + int(_loc6_[_loc13_]);
            _loc14_ = GameMapUtils.getCellPoint(_loc7_, _loc8_, _loc11_, _loc12_);
            _loc15_ = this._childMap.getValue(_loc14_.x + "," + _loc14_.y);
            if (param4 == false) {
                if (_loc15_ == null) {
                    this.drawCell(_loc14_.x, _loc14_.y, HetapFishGameConstant.MAPEDITOR_CELL_TYPE_HINDER);
                }
            } else if (_loc15_ != null) {
                removeChild(_loc15_);
            }
            _loc13_ += 2;
        }
    }

    public function drawArr(param1:Array, param2:int):void {
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            _loc4_ = 0;
            while (_loc4_ < param1[0].length) {
                _loc5_ = int(param1[_loc3_][_loc4_]);
                if (param2 == HetapFishGameConstant.TYPE_SAVE_MAP_HINDER) {
                    if (_loc5_ == 0) {
                        this.drawCell(_loc4_, _loc3_, HetapFishGameConstant.MAPEDITOR_CELL_TYPE_ROAD);
                    }
                } else if (param2 == HetapFishGameConstant.TYPE_SAVE_MAP_ROAD) {
                    if (_loc5_ == 1) {
                        this.drawCell(_loc4_, _loc3_, HetapFishGameConstant.MAPEDITOR_CELL_TYPE_HINDER);
                    }
                }
                _loc4_++;
            }
            _loc3_++;
        }
    }

    public function set cellWidth(param1:Number):void {
        this._cellWidth = param1;
    }

    public function get cellWidth():Number {
        return this._cellWidth;
    }

    public function set cellHeight(param1:Number):void {
        this._cellHeight = param1;
    }

    public function get cellHeight():Number {
        return this._cellHeight;
    }
}
}
