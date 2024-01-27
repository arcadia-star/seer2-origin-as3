package com.taomee.seer2.app.gameRule.door.util {
import flash.geom.Point;

public class PVPDoorUtil {

    public static const TARGETID:uint = 450;

    public static const MAPIDS:Array = [[402, 403], [406, 407], [410, 411], [418, 419], [422, 423]];

    private static const SELF_POSITIONS:Array = [new Point(200, 350), new Point(333, 380), new Point(333, 380), new Point(140, 480), new Point(400, 450)];


    public function PVPDoorUtil() {
        super();
    }

    public static function getSelfPosition(param1:uint):Point {
        return SELF_POSITIONS[param1 - 1];
    }
}
}
