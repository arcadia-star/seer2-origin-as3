package com.taomee.seer2.core.utils {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class DepthUtil {

    private static var _children:Array = [];


    public function DepthUtil() {
        super();
    }

    public static function sort(param1:DisplayObjectContainer):void {
        var _loc2_:int = param1.numChildren;
        _children.length = 0;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _children.push(param1.getChildAt(_loc3_));
            _loc3_++;
        }
        _children.sort(compareDisplayObject);
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_) {
            if (param1.getChildIndex(_children[_loc4_]) != _loc4_) {
                param1.setChildIndex(_children[_loc4_], _loc4_);
            }
            _loc4_++;
        }
        _children.length = 0;
    }

    private static function compareDisplayObject(param1:DisplayObject, param2:DisplayObject):int {
        if (Math.abs(param1.y - param2.y) < 2) {
            return 0;
        }
        if (param1.y > param2.y) {
            return 1;
        }
        return -1;
    }
}
}
