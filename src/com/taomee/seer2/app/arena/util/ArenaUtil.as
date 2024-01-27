package com.taomee.seer2.app.arena.util {
import com.taomee.seer2.app.arena.vibration.HorizontalDrifting;
import com.taomee.seer2.app.arena.vibration.VerticalVibration;
import com.taomee.seer2.core.map.MapModel;

import flash.display.DisplayObject;

import org.taomee.ds.HashMap;

public class ArenaUtil {

    private static var vibrateMap:HashMap = new HashMap();

    private static var horizontalDrifting:HorizontalDrifting;

    public static const UNCHECK_ANGER_SKILLS:Array = [10494, 10498, 10503];


    public function ArenaUtil() {
        super();
    }

    public static function vibrate(param1:MapModel):void {
        startVibrate(param1.ground);
        startVibrate(param1.front);
    }

    public static function drift(param1:int, param2:MapModel):void {
        if (param1 == FightSide.LEFT) {
            startDrift(DriftDirection.LEFT, param2.ground);
        } else {
            startDrift(DriftDirection.RIGHT, param2.ground);
        }
    }

    private static function startVibrate(param1:DisplayObject):void {
        var _loc2_:VerticalVibration = null;
        if (vibrateMap.containsKey(param1)) {
            _loc2_ = vibrateMap.getValue(param1);
        } else {
            _loc2_ = new VerticalVibration();
            vibrateMap.add(param1, _loc2_);
        }
        _loc2_.vibrate(param1);
    }

    private static function startDrift(param1:int, param2:DisplayObject):void {
        if (horizontalDrifting == null) {
            horizontalDrifting = new HorizontalDrifting();
        }
        horizontalDrifting.drift(param1, param2);
    }
}
}
