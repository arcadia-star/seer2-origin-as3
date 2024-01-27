package com.taomee.seer2.core.scene {
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Matrix;

import org.taomee.utils.StringUtil;

public class MapAssetExtractor {

    public static const GRID_SIZE:uint = 10;


    private var _resource:MovieClip;

    private var _width:int;

    private var _height:int;

    private var _x:Number;

    private var _y:Number;

    private var _front:Sprite;

    private var _content:Sprite;

    private var _ground:Sprite;

    private var _far:Sprite;

    private var _size:Sprite;

    private var _path:Sprite;

    private var _horizontalGridNum:uint;

    private var _verticalGridNum:uint;

    private var _gridTotal:uint;

    private var _pathData:Array;

    public function MapAssetExtractor(param1:Sprite) {
        super();
        this._resource = param1 as MovieClip;
    }

    public function extract():void {
        this.parseFront();
        this.parseContent();
        this.parseGround();
        this.parseFar();
        this.parseSize();
    }

    public function getResource():MovieClip {
        return this._resource;
    }

    private function parseFront():void {
        this._front = this._resource["front_mc"];
        this._front.mouseEnabled = false;
        this.disableNonameChildren(this._front);
    }

    private function parseContent():void {
        this._content = this._resource["content_mc"];
        this._content.mouseEnabled = false;
        this.disableNonameChildren(this._content);
    }

    private function parseGround():void {
        this._ground = this._resource["ground_mc"];
        this._ground.doubleClickEnabled = true;
        this.disableNonameChildren(this._ground);
    }

    private function parseFar():void {
        this._far = this._resource["far_mc"];
        this._far.mouseEnabled = false;
        this.disableNonameChildren(this._far);
    }

    private function parseSize():void {
        this._size = this._resource["size_mc"];
        this._width = this._size.width;
        this._height = this._size.height;
        this._x = this._size.x;
        this._y = this._size.y;
        DisplayObjectUtil.disableSprite(this._size);
    }

    public function extractPath():void {
        var _loc4_:int = 0;
        var _loc1_:Number = 1 / GRID_SIZE;
        this._path = this._resource["path_mc"];
        DisplayObjectUtil.disableSprite(this._path);
        this._path.scaleX = this._path.scaleY = _loc1_;
        this._horizontalGridNum = this._path.width;
        this._verticalGridNum = this._path.height;
        this._gridTotal = this._horizontalGridNum * this._verticalGridNum;
        var _loc2_:BitmapData = new BitmapData(this._path.width, this._path.height, true, 16777215);
        _loc2_.draw(this._path, new Matrix(_loc1_, 0, 0, _loc1_));
        this._pathData = new Array(this._horizontalGridNum);
        var _loc3_:int = 0;
        while (_loc3_ < this._horizontalGridNum) {
            this._pathData[_loc3_] = new Array(this._verticalGridNum);
            _loc4_ = 0;
            while (_loc4_ < this._verticalGridNum) {
                if (_loc2_.getPixel32(_loc3_, _loc4_) == 0) {
                    this._pathData[_loc3_][_loc4_] = true;
                } else {
                    this._pathData[_loc3_][_loc4_] = false;
                }
                _loc4_++;
            }
            _loc3_++;
        }
        _loc2_.dispose();
    }

    private function disableNonameChildren(param1:DisplayObjectContainer):void {
        var _loc3_:InteractiveObject = null;
        var _loc2_:int = param1.numChildren;
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_) {
            _loc3_ = param1.getChildAt(_loc4_) as InteractiveObject;
            if (_loc3_ != null) {
                if (this.hasGivenName(_loc3_) == false) {
                    _loc3_.mouseEnabled = false;
                    if (_loc3_ is DisplayObjectContainer) {
                        (_loc3_ as DisplayObjectContainer).mouseChildren = false;
                    }
                }
            }
            _loc4_++;
        }
    }

    private function hasGivenName(param1:InteractiveObject):Boolean {
        var _loc2_:String = "instance";
        var _loc3_:String = param1.name;
        if (_loc3_ == null || _loc3_ == "" || Boolean(StringUtil.beginsWith(_loc3_, _loc2_))) {
            return false;
        }
        return true;
    }

    public function dispose():void {
        this._resource = null;
        this._front = null;
        this._content = null;
        this._ground = null;
        this._far = null;
        this._size = null;
    }

    public function set x(param1:Number):void {
        this._x = param1;
    }

    public function set y(param1:Number):void {
        this._y = param1;
    }

    public function get x():Number {
        return this._x;
    }

    public function get y():Number {
        return this._y;
    }

    public function get width():int {
        return this._width;
    }

    public function get height():int {
        return this._height;
    }

    public function get gridSize():uint {
        return GRID_SIZE;
    }

    public function get gridX():uint {
        return this._horizontalGridNum;
    }

    public function get gridY():uint {
        return this._verticalGridNum;
    }

    public function get data():Array {
        return this._pathData;
    }

    public function get front():Sprite {
        return this._front;
    }

    public function get content():Sprite {
        return this._content;
    }

    public function get ground():Sprite {
        return this._ground;
    }

    public function get far():Sprite {
        return this._far;
    }

    public function get path():Sprite {
        return this._path;
    }
}
}
