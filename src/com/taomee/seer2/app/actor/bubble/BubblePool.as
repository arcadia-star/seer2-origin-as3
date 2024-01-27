package com.taomee.seer2.app.actor.bubble {
public class BubblePool {

    private static var _vec:Vector.<Bubble> = new Vector.<Bubble>();


    public function BubblePool() {
        super();
    }

    public static function checkOut():Bubble {
        var _loc1_:Bubble = null;
        if (_vec.length > 0) {
            _loc1_ = _vec.pop();
        }
        return new Bubble();
    }

    public static function checkIn(param1:Bubble):void {
        param1.reset();
        _vec.push(param1);
    }
}
}
