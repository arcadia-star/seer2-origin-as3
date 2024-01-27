package org.taomee.utils {
import flash.display.Shape;
import flash.events.Event;
import flash.utils.Dictionary;

public class InvalidateCallback {

    private static var _mc:Shape = new Shape();

    private static var _map:Dictionary = new Dictionary();


    public function InvalidateCallback() {
        super();
    }

    private static function onEnterFrame(param1:Event):void {
        var _loc2_:Object = null;
        var _loc3_:* = undefined;
        _mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        for (_loc3_ in _map) {
            _loc2_ = _map[_loc3_];
            if (_loc2_) {
                _loc3_(_loc2_);
            } else {
                _loc3_();
            }
        }
        _map = new Dictionary();
    }

    public static function removeFunc(param1:Function):void {
        if (param1 in _map) {
            delete _map[param1];
        }
    }

    public static function addFunc(param1:Function, param2:Object = null):void {
        _map[param1] = param2;
        _mc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }
}
}
