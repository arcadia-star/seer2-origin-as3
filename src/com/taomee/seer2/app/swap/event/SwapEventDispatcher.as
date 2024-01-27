package com.taomee.seer2.app.swap.event {
import flash.events.Event;
import flash.events.EventDispatcher;

public class SwapEventDispatcher {

    public static const NUMBER_LIMIT:String = "numberLimit";

    public static const SWAP_END:String = "swapEnd";

    private static var _instance:EventDispatcher;


    public function SwapEventDispatcher() {
        super();
    }

    private static function get instance():EventDispatcher {
        if (_instance == null) {
            _instance = new EventDispatcher();
        }
        return _instance;
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        instance.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        instance.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:Event):void {
        instance.dispatchEvent(param1);
    }

    public static function hasEventListener(param1:String):Boolean {
        return instance.hasEventListener(param1);
    }
}
}
