package com.taomee.seer2.app.plant.event {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class PlantEventControl {

    private static var _dispatcher:EventDispatcher = new EventDispatcher();


    public function PlantEventControl(param1:IEventDispatcher = null) {
        super();
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _dispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _dispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:String, param2:*, param3:* = null):void {
        if (_dispatcher.hasEventListener(param1)) {
            _dispatcher.dispatchEvent(new PlantEvent(param1, param2, param3));
        }
    }

    public static function hasEventListener(param1:String):Boolean {
        return _dispatcher.hasEventListener(param1);
    }
}
}
