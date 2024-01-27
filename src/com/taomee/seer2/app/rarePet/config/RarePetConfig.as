package com.taomee.seer2.app.rarePet.config {
import com.taomee.seer2.app.rarePet.info.RarePetInfo;
import com.taomee.seer2.app.rarePet.info.RarePetTimeInfo;

import org.taomee.ds.HashMap;

public class RarePetConfig {

    private static var _class:Class = RarePetConfig__class;

    private static var _xml:XML;

    private static var _hashMap:HashMap;

    {
        setup();
    }

    public function RarePetConfig() {
        super();
    }

    private static function setup():void {
        var _loc2_:XML = null;
        var _loc3_:RarePetInfo = null;
        var _loc4_:XMLList = null;
        var _loc5_:XML = null;
        var _loc6_:RarePetTimeInfo = null;
        var _loc7_:String = null;
        var _loc8_:String = null;
        _hashMap = new HashMap();
        _xml = XML(new _class());
        var _loc1_:XMLList = _xml.descendants("pet");
        for each(_loc2_ in _loc1_) {
            _loc3_ = new RarePetInfo();
            _loc3_.index = int(_loc2_.attribute("index"));
            _loc3_.id = int(_loc2_.attribute("id"));
            _loc3_.name = _loc2_.attribute("name");
            _loc3_.level = int(_loc2_.attribute("level"));
            _loc3_.mapId = int(_loc2_.attribute("mapId"));
            _loc3_.intervalTime = int(_loc2_.attribute("intervalTime"));
            _loc3_.DayLimitType = int(_loc2_.attribute("DayLimitType"));
            _loc3_.DayMaxNum = int(_loc2_.attribute("DayMaxNum"));
            _loc4_ = _loc2_.descendants("Time");
            for each(_loc5_ in _loc4_) {
                (_loc6_ = new RarePetTimeInfo()).day = int(_loc5_.attribute("Day"));
                _loc7_ = _loc5_.attribute("startTime");
                _loc8_ = _loc5_.attribute("endTime");
                _loc6_.startTime = int(_loc7_.split(" ")[0]) * 60 + int(_loc7_.split(" ")[1]);
                _loc6_.endTime = int(_loc8_.split(" ")[0]) * 60 + int(_loc8_.split(" ")[1]);
                _loc3_.timeInfoMap.add(_loc6_.day, _loc6_);
            }
            _hashMap.add(_loc3_.id, _loc3_);
        }
    }

    public static function getRarePetInfo(param1:int):RarePetInfo {
        return _hashMap.getValue(param1);
    }

    public static function getAllRarePetIds():Vector.<int> {
        return Vector.<int>(_hashMap.getKeys());
    }

    public static function getAllRelatedMapIds():Vector.<int> {
        var _loc3_:RarePetInfo = null;
        var _loc1_:Vector.<int> = new Vector.<int>();
        var _loc2_:Array = _hashMap.getValues();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.mapId != 0 && _loc1_.indexOf(_loc3_.mapId) == -1) {
                _loc1_.push(_loc3_.mapId);
            }
        }
        return _loc1_;
    }
}
}
