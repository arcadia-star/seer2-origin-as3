package com.taomee.seer2.core.map.grids {
import flash.events.Event;

public class WalkEvent extends Event {

    public static const WALK_START:String = "walk_Start";

    public static const WALK_END:String = "walk_end";

    public static const ON_WALK:String = "on_walk";


    private var _pathArray:Array;

    private var _mapNodeSize:uint;

    private var _moveToX:Number;

    private var _moveToY:Number;

    public function WalkEvent(param1:String = null, param2:Object = null) {
        super(param1 != null ? param1 : WALK_START);
    }

    public function set pathArray(param1:Array):void {
        this._pathArray = param1;
    }

    public function get pathArray():Array {
        return this._pathArray;
    }

    public function set mapNodeSize(param1:uint):void {
        this._mapNodeSize = param1;
    }

    public function get mapNodeSize():uint {
        return this._mapNodeSize;
    }

    public function set moveToX(param1:Number):void {
        this._moveToX = param1;
    }

    public function get moveToX():Number {
        return this._moveToX;
    }

    public function set moveToY(param1:Number):void {
        this._moveToY = param1;
    }

    public function get moveToY():Number {
        return this._moveToY;
    }
}
}
