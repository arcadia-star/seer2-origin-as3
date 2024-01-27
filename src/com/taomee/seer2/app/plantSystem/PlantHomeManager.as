package com.taomee.seer2.app.plantSystem {
public class PlantHomeManager {

    public static var homeLevel:uint;

    public static var plantList:Vector.<PlantLand>;


    public function PlantHomeManager() {
        super();
    }

    public static function getOpenCount():uint {
        var _loc2_:PlantLand = null;
        var _loc1_:uint = 0;
        for each(_loc2_ in plantList) {
            if (_loc2_.info.plantIsOpen != 0 && _loc2_.info.plantIsVip != 1) {
                _loc1_++;
            }
        }
        return _loc1_;
    }

    public static function getVipOpenCount():uint {
        var _loc2_:PlantLand = null;
        var _loc1_:uint = 0;
        for each(_loc2_ in plantList) {
            if (Boolean(_loc2_.info.plantIsOpen) && _loc2_.info.plantIsVip == 1) {
                _loc1_++;
            }
        }
        return _loc1_;
    }
}
}
