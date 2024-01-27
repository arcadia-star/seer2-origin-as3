package com.taomee.seer2.app.pet.effect {
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;

import org.taomee.ds.HashMap;

public class SpawnedPetPresentEffectPool {

    private static var _poolMap:HashMap;

    {
        initialize();
    }

    public function SpawnedPetPresentEffectPool() {
        super();
    }

    private static function initialize():void {
        _poolMap = new HashMap();
    }

    public static function checkout(param1:uint):MovieClip {
        var _loc2_:MovieClip = null;
        var _loc3_:Vector.<MovieClip> = getSpawnEffectPool(param1);
        if (_loc3_.length > 0) {
            _loc2_ = _loc3_.pop();
        } else {
            _loc2_ = UIManager.getMovieClip("UI_PetSpawnEffect_" + param1);
        }
        if (_loc2_) {
            _loc2_.play();
        }
        return _loc2_;
    }

    private static function getSpawnEffectPool(param1:uint):Vector.<MovieClip> {
        if (_poolMap.containsKey(param1) == false) {
            _poolMap.add(param1, new Vector.<MovieClip>());
        }
        return _poolMap.getValue(param1) as Vector.<MovieClip>;
    }

    public static function checkin(param1:MovieClip, param2:uint):void {
        var _loc3_:Vector.<MovieClip> = getSpawnEffectPool(param2);
        _loc3_.push(param1);
    }
}
}
