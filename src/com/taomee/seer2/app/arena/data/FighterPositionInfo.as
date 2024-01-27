package com.taomee.seer2.app.arena.data {
import flash.geom.Point;

public class FighterPositionInfo {


    public var targetX:Number = 0;

    public var targetY:Number = 0;

    public var targetScaleX:Number = 1;

    public var targetScaleY:Number = 1;

    public function FighterPositionInfo() {
        super();
    }

    public function get point():Point {
        return new Point(this.targetX, this.targetY);
    }
}
}
