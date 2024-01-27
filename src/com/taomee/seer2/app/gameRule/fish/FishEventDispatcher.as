package com.taomee.seer2.app.gameRule.fish {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class FishEventDispatcher extends EventDispatcher {

    private static var _instance:FishEventDispatcher;


    public function FishEventDispatcher(param1:IEventDispatcher = null) {
        super(param1);
    }

    public static function getInstance():FishEventDispatcher {
        if (_instance == null) {
            _instance = new FishEventDispatcher();
        }
        return _instance;
    }
}
}
