package com.taomee.seer2.app.config {
import org.taomee.ds.HashMap;

public class PetSpirtTrainConfig {

    private static var _xmlClass:Class = PetSpirtTrainConfig__xmlClass;

    private static var _configXML:XML;

    private static var _introdueInfo:Array;

    private static var _titleInfo:HashMap;

    {
        setup();
    }

    public function PetSpirtTrainConfig() {
        super();
    }

    private static function setup():void {
        var _loc1_:Object = null;
        var _loc2_:XML = null;
        var _loc3_:XML = null;
        _configXML = XML(new _xmlClass());
        _introdueInfo = [];
        _titleInfo = new HashMap();
        for each(_loc2_ in _configXML["introduce"]["item"]) {
            _loc1_ = new Object();
            _loc1_["id"] = int(_loc2_.@id);
            _loc1_["isNew"] = int(_loc2_.@isNew);
            _loc1_["isHot"] = int(_loc2_.@isHot);
            _loc1_["go"] = String(_loc2_.@go);
            _introdueInfo.push(_loc1_);
        }
        for each(_loc3_ in _configXML["title"]["item"]) {
            _loc1_ = new Object();
            _loc1_["resId"] = int(_loc3_.@resId);
            _loc1_["skillInfo"] = String(_loc3_.@skillInfo);
            _loc1_["charactor"] = String(_loc3_.@charactor);
            _loc1_["getWay"] = String(_loc3_.@getWay);
            _loc1_["go"] = String(_loc3_.@go);
            _titleInfo.add(_loc1_["resId"], _loc1_);
        }
    }

    public static function get introdueInfo():Array {
        return _introdueInfo;
    }

    public static function getTitleByResId(param1:int):Object {
        return _titleInfo.getValue(param1);
    }
}
}
