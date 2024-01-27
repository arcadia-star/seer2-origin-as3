package com.taomee.seer2.app.config {
public class PlantBubbleConfig {

    private static var _class:Class = PlantBubbleConfig__class;

    private static var _xml:XML;

    private static var _currXmlList:XMLList;

    private static var _sowList:Vector.<String>;

    private static var _removeList:Vector.<String>;

    private static var _getList:Vector.<String>;

    private static var _openPlantList:Vector.<String>;

    private static var _stealPlantList:Vector.<String>;

    private static var _fertilizer:Vector.<String>;

    {
        setup();
    }

    public function PlantBubbleConfig() {
        super();
    }

    private static function setup():void {
        _xml = XML(new _class());
        _currXmlList = _xml.descendants("sow");
        _sowList = Vector.<String>([]);
        entry(_sowList);
        _currXmlList = _xml.descendants("remove");
        _removeList = Vector.<String>([]);
        entry(_removeList);
        _currXmlList = _xml.descendants("get");
        _getList = Vector.<String>([]);
        entry(_getList);
        _currXmlList = _xml.descendants("openPlant");
        _openPlantList = Vector.<String>([]);
        entry(_openPlantList);
        _currXmlList = _xml.descendants("steal");
        _stealPlantList = Vector.<String>([]);
        entry(_stealPlantList);
        _currXmlList = _xml.descendants("fertilizer");
        _fertilizer = Vector.<String>([]);
        entry(_fertilizer);
    }

    private static function entry(param1:Vector.<String>):void {
        var _loc2_:String = null;
        var _loc3_:XML = null;
        for each(_loc3_ in _currXmlList.descendants("item")) {
            _loc2_ = String(_loc3_.attribute("str"));
            param1.push(_loc2_);
        }
    }

    public static function getStr(param1:uint):String {
        var _loc2_:Vector.<String> = getInfoList(param1);
        var _loc3_:int = int(Math.random() * _loc2_.length);
        return _loc2_[_loc3_];
    }

    public static function getInfoList(param1:uint):Vector.<String> {
        var _loc2_:Vector.<String> = null;
        switch (param1) {
            case 1:
                _loc2_ = _sowList;
                break;
            case 2:
                _loc2_ = _removeList;
                break;
            case 3:
                _loc2_ = _getList;
                break;
            case 4:
                _loc2_ = _openPlantList;
                break;
            case 5:
                _loc2_ = _stealPlantList;
                break;
            case 6:
                _loc2_ = _fertilizer;
        }
        return _loc2_;
    }
}
}
