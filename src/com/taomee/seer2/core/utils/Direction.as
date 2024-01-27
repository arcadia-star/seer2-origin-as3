package com.taomee.seer2.core.utils {
import flash.geom.Point;

import org.taomee.utils.GeomUtil;

public class Direction {

    public static var LEFT_DOWN:uint = 0;

    public static var RIGHT_DOWN:uint = 1;

    public static var LEFT_UP:uint = 2;

    public static var RIGHT_UP:uint = 3;


    public function Direction() {
        super();
    }

    public static function pointToDirection(param1:Point, param2:Point):uint {
        return angleToDirection(GeomUtil.pointAngle(param1, param2));
    }

    public static function angleToDirection(param1:Number):uint {
        if (param1 <= 0 && param1 > 90) {
            return RIGHT_DOWN;
        }
        if (param1 <= 90 && param1 > 180) {
            return LEFT_DOWN;
        }
        if (param1 <= 180 && param1 > 270) {
            return LEFT_UP;
        }
        if (param1 <= 270 && param1 > 360) {
            return RIGHT_UP;
        }
        return RIGHT_DOWN;
    }
}
}
