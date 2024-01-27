package com.taomee.seer2.core.cache {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.system.ApplicationDomain;

import org.taomee.ds.HashMap;
import org.taomee.utils.DomainUtil;

public class ShootCache {

    private static var _map:HashMap = new HashMap();


    public function ShootCache() {
        super();
    }

    public static function contains(param1:uint):Boolean {
        return _map.containsKey(param1);
    }

    public static function getEffectMovieClip(param1:uint, param2:int):MovieClip {
        var _loc3_:ApplicationDomain = _map.getValue(param1);
        if (_loc3_) {
            return DomainUtil.getMovieClip("Effect_" + param2.toString(), _loc3_);
        }
        return null;
    }

    public static function getStateMovieClip(param1:uint, param2:int):MovieClip {
        var _loc3_:ApplicationDomain = _map.getValue(param1);
        if (_loc3_) {
            return DomainUtil.getMovieClip("State_" + param2.toString(), _loc3_);
        }
        return null;
    }

    public static function load(param1:uint):void {
        QueueLoader.load(URLUtil.getShootSwf(param1), LoadType.DOMAIN, onComplete, null, param1);
    }

    private static function onComplete(param1:ContentInfo):void {
        if (param1.content != null) {
            _map.add(param1.data, param1.content);
        }
    }
}
}
