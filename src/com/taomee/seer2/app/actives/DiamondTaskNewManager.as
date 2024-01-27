package com.taomee.seer2.app.actives {
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.events.Event;

import org.taomee.manager.EventManager;

public class DiamondTaskNewManager {

    private static const mapIdList:Vector.<uint> = Vector.<uint>([213, 360, 891]);

    private static var _currIndex:int;


    public function DiamondTaskNewManager() {
        super();
    }

    public static function setup():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
    }

    private static function onComplete(param1:SceneEvent):void {
        var _loc2_:uint = uint(SceneManager.active.mapID);
        _currIndex = mapIdList.indexOf(_loc2_);
        if (_currIndex != -1) {
            EventManager.dispatchEvent(new Event("DiamondTaskEvent"));
        }
    }
}
}
