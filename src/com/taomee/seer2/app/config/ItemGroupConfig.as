package com.taomee.seer2.app.config {
import com.taomee.seer2.app.inventory.ItemDescription;
import com.taomee.seer2.app.inventory.ItemGroup;

import org.taomee.ds.HashMap;

public class ItemGroupConfig {

    private static var _xmlClass:Class = ItemGroupConfig__xmlClass;

    private static var _xml:XML;

    private static var _molecurlarPwdMap:HashMap;

    private static var _giftMap:HashMap;

    {
        initialize();
    }

    public function ItemGroupConfig() {
        super();
    }

    private static function initialize():void {
        _xml = XML(new _xmlClass());
        _molecurlarPwdMap = new HashMap();
        _giftMap = new HashMap();
        parseXml(_molecurlarPwdMap, ItemGroup.MOLECULAR_PASSWORD);
        parseXml(_giftMap, ItemGroup.DAILY_QUEST);
    }

    private static function parseXml(param1:HashMap, param2:String):void {
        var _loc3_:XML = null;
        var _loc4_:XML = null;
        var _loc5_:int = 0;
        var _loc6_:Vector.<ItemDescription> = null;
        var _loc7_:XML = null;
        var _loc8_:Boolean = false;
        var _loc9_:ItemDescription = null;
        for each(_loc3_ in _xml.children()) {
            if (_loc3_.attribute("name").toString() == param2) {
                for each(_loc4_ in _loc3_.child("group")) {
                    _loc5_ = int(_loc4_.attribute("id"));
                    _loc6_ = new Vector.<ItemDescription>();
                    for each(_loc7_ in _loc4_.child("item")) {
                        _loc8_ = Boolean(_loc7_.attribute("isPet")) && String(_loc7_.attribute("isPet")) == "true";
                        _loc9_ = new ItemDescription(int(_loc7_.attribute("id")), int(_loc7_.attribute("count")), 0, _loc8_);
                        _loc6_.push(_loc9_);
                    }
                    param1.add(_loc5_, new ItemGroup(_loc5_, param2, _loc6_));
                }
                return;
            }
        }
    }

    private static function getMap(param1:String):HashMap {
        var _loc2_:HashMap = null;
        switch (param1) {
            case ItemGroup.MOLECULAR_PASSWORD:
                _loc2_ = _molecurlarPwdMap;
                break;
            case ItemGroup.DAILY_QUEST:
                _loc2_ = _giftMap;
        }
        return _loc2_;
    }

    public static function getItemGroupVec(param1:String):Vector.<ItemGroup> {
        var _loc4_:ItemGroup = null;
        var _loc2_:HashMap = getMap(param1);
        var _loc3_:Vector.<ItemGroup> = new Vector.<ItemGroup>();
        for each(_loc4_ in _loc2_.getValues()) {
            _loc3_.push(_loc4_);
        }
        return _loc3_;
    }

    public static function getGroup(param1:String, param2:Vector.<ItemDescription>):ItemGroup {
        var _loc4_:int = 0;
        var _loc5_:ItemGroup = null;
        var _loc3_:HashMap = getMap(param1);
        for each(_loc4_ in _loc3_.getKeys()) {
            if ((_loc5_ = _loc3_.getValue(_loc4_)).contains(param2)) {
                return _loc5_;
            }
        }
        return null;
    }
}
}
