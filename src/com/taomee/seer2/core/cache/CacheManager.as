package com.taomee.seer2.core.cache {
import com.taomee.seer2.core.loader.LoadType;

import org.taomee.ds.HashMap;

public class CacheManager {

    private static var _cacheMap:HashMap = new HashMap();


    public function CacheManager() {
        super();
    }

    public static function getContent(param1:String, param2:String, param3:Function, param4:Function = null, param5:* = null, param6:int = 2, param7:Function = null, param8:Function = null):void {
        getCacheImpl(param2).getContent(param1, getLoadType(param2), param3, param4, param5, param6, param7, param8);
    }

    public static function cancel(param1:String, param2:String, param3:Function):void {
        getCacheImpl(param2).cancel(param1, param3);
    }

    public static function clear(param1:String):void {
        getCacheImpl(param1).clear();
    }

    private static function getCacheImpl(param1:String):CacheImpl {
        var _loc2_:CacheImpl = _cacheMap.getValue(param1);
        if (_loc2_ == null) {
            switch (param1) {
                case CacheType.PHASOR:
                    _loc2_ = new PhasorParse();
                    _loc2_.name = "item";
                    break;
                case CacheType.EFFECT:
                    _loc2_ = new PhasorParse();
                    _loc2_.name = "effect";
                    break;
                case CacheType.PET:
                    _loc2_ = new PhasorParse();
                    _loc2_.name = "pet";
                    break;
                default:
                    _loc2_ = new CacheImpl();
            }
            _loc2_.maxCount = getMaxCount(param1);
            _cacheMap.add(param1, _loc2_);
        }
        return _loc2_;
    }

    private static function getLoadType(param1:String):String {
        switch (param1) {
            case CacheType.EQUIP:
                return LoadType.BINARY;
            case CacheType.PHASOR:
            case CacheType.EFFECT:
            case CacheType.PET:
                return LoadType.DOMAIN;
            case CacheType.SOUND:
                return LoadType.SOUND;
            default:
                return "";
        }
    }

    private static function getMaxCount(param1:String):int {
        switch (param1) {
            case CacheType.EFFECT:
                return 100;
            case CacheType.EQUIP:
                return 100;
            case CacheType.PET:
                return 50;
            case CacheType.PHASOR:
                return 100;
            case CacheType.SOUND:
                return 100;
            default:
                return 50;
        }
    }
}
}
