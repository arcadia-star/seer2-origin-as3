package com.taomee.seer2.app.npc {
import com.taomee.seer2.core.entity.definition.NpcDefinition;

import flash.events.EventDispatcher;

public class NpcManager {

    private static var _dispatcher:EventDispatcher = new EventDispatcher();


    public function NpcManager() {
        super();
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _dispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _dispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:String, param2:NpcDefinition):void {
        if (_dispatcher.hasEventListener(param1)) {
            _dispatcher.dispatchEvent(new NpcEvent(param1, param2));
        }
    }

    public static function hasEventListener(param1:String):Boolean {
        return _dispatcher.hasEventListener(param1);
    }
}
}
