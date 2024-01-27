package com.taomee.seer2.core.effects {
import com.greensock.TweenLite;
import com.greensock.easing.Elastic;

import flash.display.InteractiveObject;

public class MotionEffects {


    public function MotionEffects() {
        super();
    }

    public static function execElastic(param1:InteractiveObject):void {
        TweenLite.to(param1, 0, {
            "scaleX": 0.7,
            "scaleY": 0.7
        });
        TweenLite.to(param1, 1, {
            "scaleX": 1,
            "scaleY": 1,
            "ease": Elastic.easeOut
        });
    }

    public static function resetScale(param1:InteractiveObject):void {
        param1.scaleX = 1;
        param1.scaleY = 1;
    }
}
}
