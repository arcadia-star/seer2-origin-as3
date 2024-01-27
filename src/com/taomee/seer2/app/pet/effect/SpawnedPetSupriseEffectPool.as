package com.taomee.seer2.app.pet.effect {
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;

public class SpawnedPetSupriseEffectPool {

    private static var _pool:Vector.<MovieClip>;

    {
        initialize();
    }

    public function SpawnedPetSupriseEffectPool() {
        super();
    }

    private static function initialize():void {
        _pool = new Vector.<MovieClip>();
    }

    public static function checkout():MovieClip {
        var _loc1_:MovieClip = null;
        if (_pool.length > 0) {
            _loc1_ = _pool.pop();
        } else {
            _loc1_ = UIManager.getMovieClip("UI_FightSuprise");
        }
        _loc1_.play();
        return _loc1_;
    }

    public static function checkin(param1:MovieClip):void {
        _pool.push(param1);
    }
}
}
