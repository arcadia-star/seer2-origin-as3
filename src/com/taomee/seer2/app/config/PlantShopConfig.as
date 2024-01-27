package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.PlantShopInfo;

public class PlantShopConfig {

    private static var _class:Class = PlantShopConfig__class;

    private static var _xml:XML;

    private static var _currXmlList:XMLList;

    private static var _normalList:Vector.<PlantShopInfo>;

    private static var _upList:Vector.<PlantShopInfo>;

    private static var _vipList:Vector.<PlantShopInfo>;

    private static var _sellShopList:Vector.<PlantShopInfo>;

    {
        setup();
    }

    public function PlantShopConfig() {
        super();
    }

    private static function setup():void {
        _xml = XML(new _class());
        _currXmlList = _xml.descendants("normalShop");
        _normalList = Vector.<PlantShopInfo>([]);
        entry(_normalList, 1);
        _currXmlList = _xml.descendants("upShop");
        _upList = Vector.<PlantShopInfo>([]);
        entry(_upList, 2);
        _currXmlList = _xml.descendants("vipShop");
        _vipList = Vector.<PlantShopInfo>([]);
        entry(_vipList, 3);
        _currXmlList = _xml.descendants("sellShop");
        _sellShopList = Vector.<PlantShopInfo>([]);
        entry(_sellShopList, 4);
    }

    private static function entry(param1:Vector.<PlantShopInfo>, param2:uint):void {
        var _loc3_:PlantShopInfo = null;
        var _loc4_:XML = null;
        for each(_loc4_ in _currXmlList.descendants("item")) {
            _loc3_ = new PlantShopInfo();
            _loc3_.type = param2;
            _loc3_.id = uint(_loc4_.attribute("referenceId"));
            _loc3_.price = Number(_loc4_.attribute("price"));
            param1.push(_loc3_);
        }
    }

    public static function getInfoList(param1:uint):Vector.<PlantShopInfo> {
        var _loc2_:Vector.<PlantShopInfo> = null;
        switch (param1) {
            case 1:
                _loc2_ = _normalList;
                break;
            case 2:
                _loc2_ = _upList;
                break;
            case 3:
                _loc2_ = _vipList;
                break;
            case 4:
                _loc2_ = _sellShopList;
        }
        return _loc2_;
    }
}
}
