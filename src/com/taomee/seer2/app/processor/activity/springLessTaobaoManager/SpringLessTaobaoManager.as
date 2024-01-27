package com.taomee.seer2.app.processor.activity.springLessTaobaoManager {
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.core.manager.TimeManager;

import flash.events.Event;

public class SpringLessTaobaoManager {

    private static const itemIdList:Vector.<uint> = Vector.<uint>([801089, 801090, 801093, 801094, 801095, 201069, 201070, 201071, 201077, 201078, 203339, 203340, 203341, 203342, 203482, 203483, 203484, 201113, 401200, 206667, 201109, 401121, 801149, 801150, 801151, 801092, 801131, 801132, 801133, 801134, 801135, 203481, 203480]);

    private static var _prevMinutes:uint;


    public function SpringLessTaobaoManager() {
        super();
    }

    public static function setup():void {
        TimeManager.addEventListener(TimeManager.TIME_UPDATE, onTimeUpdate);
    }

    private static function onTimeUpdate(param1:Event):void {
        var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc2_.hours >= 13 && _loc2_.hours < 15 || _loc2_.hours >= 18 && _loc2_.hours < 21) {
            updateShow(_loc2_);
        } else if (_loc2_.hours == 15 && _loc2_.minutes < 10) {
            updateShow(_loc2_);
        } else if (_loc2_.hours == 21 && _loc2_.minutes < 10) {
            updateShow(_loc2_);
        }
    }

    private static function updateShow(param1:Date):void {
        var _loc2_:uint = 0;
        if (param1.minutes % 10 == 0 && param1.minutes != _prevMinutes) {
            _prevMinutes = param1.minutes;
            _loc2_ = uint(Math.random() * itemIdList.length);
            ToolBar.addSpringLess(itemIdList[_loc2_]);
        }
    }
}
}
