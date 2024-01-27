package com.taomee.seer2.app.config {
import org.taomee.ds.HashMap;

public class MapConfig {

    private static var _xmlClass:Class = MapConfig__xmlClass;

    private static var mapMap:HashMap = new HashMap();

    {
        initlize();
    }

    public function MapConfig() {
        super();
    }

    private static function initlize():void {
        var _loc3_:MapInfo = null;
        var _loc4_:XML = null;
        var _loc1_:XML = XML(new _xmlClass());
        var _loc2_:XMLList = _loc1_.child("Map");
        for each(_loc4_ in _loc2_) {
            _loc3_ = new MapInfo();
            _loc3_.id = _loc4_.@ID;
            _loc3_.name = _loc4_.@Name;
            mapMap.add(_loc3_.id, _loc3_);
        }
    }

    public static function getMapInfo(param1:uint):MapInfo {
        if (mapMap.containsKey(param1)) {
            return mapMap.getValue(param1);
        }
        return null;
    }

    public static function formMapNameGetMapId(param1:String):int {
        var _loc2_:int = 0;
        var _loc3_:uint = 0;
        while (_loc3_ < mapMap.getValues().length) {
            if ((mapMap.getValues()[_loc3_] as MapInfo).name == param1) {
                _loc2_ = int(mapMap.getKeys()[_loc3_]);
                break;
            }
            _loc3_++;
        }
        return _loc2_;
    }
}
}
