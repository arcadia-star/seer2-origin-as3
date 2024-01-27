package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.SeedGetInfo;
import com.taomee.seer2.app.config.info.SeedInfo;

import org.taomee.ds.HashMap;

public class SeedConfig {

    private static var _class:Class = SeedConfig__class;

    private static var _xml:XML;

    private static var _hashMap:HashMap;

    {
        setup();
    }

    public function SeedConfig() {
        super();
    }

    private static function setup():void {
        var _loc2_:XML = null;
        var _loc3_:SeedInfo = null;
        var _loc4_:XMLList = null;
        var _loc5_:XML = null;
        var _loc6_:SeedGetInfo = null;
        _hashMap = new HashMap();
        _xml = XML(new _class());
        var _loc1_:XMLList = _xml.descendants("Item");
        for each(_loc2_ in _loc1_) {
            _loc3_ = new SeedInfo();
            _loc3_.id = int(_loc2_.attribute("ID"));
            _loc3_.seedId = int(_loc2_.attribute("seed_id"));
            _loc3_.name = _loc2_.attribute("name");
            _loc3_.level = int(_loc2_.attribute("level"));
            _loc3_.harvestTime = int(_loc2_.attribute("harvest_time"));
            _loc3_.season = int(_loc2_.attribute("season"));
            _loc3_.shopType = int(_loc2_.attribute("shop_type"));
            _loc4_ = _loc2_.descendants("Item");
            _loc3_.getList = Vector.<SeedGetInfo>([]);
            for each(_loc5_ in _loc4_) {
                (_loc6_ = new SeedGetInfo()).id = int(_loc5_.attribute("id"));
                _loc6_.rate = int(_loc5_.attribute("rate"));
                _loc6_.stealRate = int(_loc5_.attribute("steal_rate"));
                _loc6_.num = int(_loc5_.attribute("num"));
                _loc3_.getList.push(_loc6_);
            }
            _hashMap.add(_loc3_.seedId, _loc3_);
        }
    }

    public static function getSeedInfo(param1:int):SeedInfo {
        return _hashMap.getValue(param1);
    }

    public static function getAllSeedInfo():Vector.<SeedInfo> {
        var _loc1_:Vector.<SeedInfo> = Vector.<SeedInfo>(_hashMap.getValues());
        _loc1_.sort(sortUpdate);
        return _loc1_;
    }

    private static function sortUpdate(param1:SeedInfo, param2:SeedInfo):int {
        if (param1.id > param2.id) {
            return 1;
        }
        if (param1.id < param2.id) {
            return -1;
        }
        return 0;
    }
}
}
