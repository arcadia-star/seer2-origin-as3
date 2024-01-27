package com.taomee.seer2.core.map.grids {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.system.Capabilities;

public class HeptaFishCharacter extends HeptaFishBitMapMC {

    public static const STAND:int = 0;

    public static const SIT:int = 1;

    public static const RUN:int = 2;

    public static const NOT_MIRROR:int = 1;

    public static const IS_MIRROR:int = -1;


    protected var _nowX:uint;

    protected var _nowY:uint;

    protected var _dirX:int;

    protected var _dirY:int;

    protected var _walkStep:uint;

    protected var _walkArray:Array;

    protected var _isWalk:Boolean;

    protected var _modules:Array;

    protected var _walkIndex:int;

    private var _moveToX:uint;

    private var _moveToY:uint;

    private var _mapNodeSize:uint;

    protected var _aimx:Number;

    protected var _aimy:Number;

    private var _angle:Number;

    private var _distance:Number;

    private var _isSit:Boolean;

    private var _lastFrameX:int;

    private var _dire:int;

    private var _faceToScreen:Boolean;

    private var _mapScene:GameMap;

    private var _moveSpeed:int = 8;

    private var _filter:BitmapData;

    private var _rect:Rectangle;

    public function HeptaFishCharacter(param1:Bitmap, param2:Boolean = true, param3:int = 1, param4:int = 1, param5:int = 0, param6:int = 0, param7:int = 0, param8:int = 0, param9:int = 0, param10:Number = 0.27777, param11:* = null, param12:Number = -1, param13:Number = -1) {
        this._modules = new Array();
        super(param1, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13);
        this._aimx = x;
        this._aimy = y;
        _isMirror = param2;
        this._filter = new BitmapData(this.width, this.height);
        this._rect = new Rectangle(0, 0, this.width, this.height);
        this._filter.fillRect(this._rect, 4278190335);
    }

    public function moveCharacter(param1:WalkEvent):void {
        if (this._isWalk) {
            this.stopCharacter();
        }
        this._walkArray = param1.pathArray;
        this._walkIndex = 0;
        this._isWalk = true;
        this._moveToX = param1.moveToX;
        this._moveToY = param1.moveToY;
        this._mapNodeSize = param1.mapNodeSize;
        addEventListener(Event.ENTER_FRAME, this.onMove);
    }

    public function moveTo(param1:Number, param2:Number):void {
        this._aimx = param1;
        this._aimy = param2;
        this._angle = Math.atan2(this._aimy - y, this._aimx - x);
        this._distance = (this._aimy - y) * (this._aimy - y) + (this._aimx - x) * (this._aimx - x);
        this._isSit = false;
        this._dire = Math.round((this._angle + Math.PI) / (Math.PI / 4));
        this._dire = this._dire > 5 ? this._dire - 6 : this._dire + 2;
        if (_isMirror) {
            if (this._dire > 4) {
                this._dire = this._dire == 5 ? 3 : (this._dire == 6 ? 2 : 1);
                mirror(IS_MIRROR);
            } else {
                mirror(NOT_MIRROR);
            }
        }
        nowIndex = this._dire;
        this.startMove(nowIndex);
        addEventListener(Event.ENTER_FRAME, this.onMove);
    }

    protected function onMove(param1:Event):void {
        var _loc2_:Number = 10 * Math.cos(this._angle);
        var _loc3_:Number = 10 * Math.sin(this._angle);
        var _loc4_:Number = this._aimx - x;
        var _loc5_:Number = this._aimy - y;
        var _loc6_:Number = _loc4_ * _loc4_ + _loc5_ * _loc5_;
        x += _loc2_ / 2;
        y += _loc3_ / 2;
        var _loc7_:Number = this._mapScene.x - _loc2_ / 2;
        var _loc8_:Number = this._mapScene.y - _loc3_ / 2;
        var _loc9_:Number = Capabilities.screenResolutionX;
        var _loc10_:Number = Capabilities.screenResolutionY;
        if (_loc7_ < 0 && _loc7_ > -(this._mapScene.mapWidth - _loc9_) && x >= _loc9_ / 2 && x <= this._mapScene.mapWidth - _loc9_ / 2) {
            this._mapScene.x -= _loc2_ / 2;
        }
        if (_loc8_ < 0 && _loc8_ > -(this._mapScene.mapHeight - _loc10_) && y >= _loc10_ / 2 && y <= this._mapScene.mapHeight - _loc10_ / 2) {
            this._mapScene.y -= _loc3_ / 2;
        }
        if (_loc3_ > 0) {
            this._faceToScreen = true;
        } else if (_loc3_ < 0) {
            this._faceToScreen = false;
        }
        Debuger.STATIC_DEBUG_MSG = this._mapScene.x + "_" + this._mapScene.y;
        if (_loc6_ < _speed * _speed || this._distance < _loc6_) {
            x = this._aimx;
            y = this._aimy;
            this.stopCharacter();
            dispatch(WalkEvent, WalkEvent.WALK_END);
        } else {
            this._distance = _loc6_;
            dispatch(WalkEvent, WalkEvent.ON_WALK);
        }
        this._mapScene.mapLayer.checkLoad(new Point(this.x, this.y));
    }

    public function stopCharacter():void {
        removeEventListener(Event.ENTER_FRAME, this.onMove);
        stopMove();
    }

    public function get moveToX():Number {
        return this._moveToX;
    }

    public function get moveToY():Number {
        return this._moveToY;
    }

    public function set moveToX(param1:Number):void {
        this._moveToX = param1;
    }

    public function set moveToY(param1:Number):void {
        this._moveToY = param1;
    }

    public function set mapEle(param1:GameMap):void {
        this._mapScene = param1;
    }

    public function get faceToscreen():Boolean {
        return this._faceToScreen;
    }

    public function get rect():Rectangle {
        return this._rect;
    }

    public function get filter():BitmapData {
        return this._filter;
    }

    private function moveMap(param1:Number, param2:Number):void {
    }
}
}
