package com.taomee.seer2.app.lobby.setting {
import com.taomee.seer2.core.utils.DateUtil;

public class LobbyMapSetting {

    private static var _settingXML:XML;

    private static var _mapSettingVector:Array;

    {
        initialize();
    }

    public function LobbyMapSetting() {
        super();
    }

    private static function initialize():void {
        _mapSettingVector = new Array();
    }

    public static function parseSetting(param1:XML):void {
        var _loc3_:XML = null;
        var _loc4_:uint = 0;
        var _loc5_:uint = 0;
        var _loc6_:* = false;
        _settingXML = param1;
        var _loc2_:XMLList = _settingXML.elements("map");
        for each(_loc3_ in _loc2_) {
            _loc4_ = uint(_loc3_.attribute("dayId").toString());
            _loc5_ = 0;
            if (_loc3_.hasOwnProperty("nightId") != null) {
                _loc5_ = uint(_loc3_.attribute("nightId").toString());
            }
            _loc6_ = false;
            if (_loc3_.hasOwnProperty("change") != null) {
                _loc6_ = uint(_loc3_.attribute("change").toString()) == 1;
            }
            _mapSettingVector.push(new MapSetting(_loc4_, _loc5_, _loc6_));
        }
    }

    public static function get isInitialized():Boolean {
        if (_settingXML != null) {
            return true;
        }
        return false;
    }

    private static function getMapSetting(param1:uint):MapSetting {
        var _loc2_:MapSetting = null;
        var _loc3_:uint = _mapSettingVector.length;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            if (_mapSettingVector[_loc4_].dayId == param1 || _mapSettingVector[_loc4_].nightId == param1) {
                _loc2_ = _mapSettingVector[_loc4_];
                break;
            }
            _loc4_++;
        }
        return _loc2_;
    }

    public static function getMapId(param1:int):int {
        var _loc2_:int = param1;
        var _loc3_:MapSetting = getMapSetting(param1);
        if (_loc3_) {
            if (_loc3_.change) {
                _loc2_ = !!DateUtil.isNight() ? int(_loc3_.nightId) : int(_loc3_.dayId);
            } else {
                _loc2_ = int(_loc3_.dayId);
            }
        }
        return _loc2_;
    }

    public static function getResourceId(param1:int):int {
        var _loc2_:int = param1;
        var _loc3_:MapSetting = getMapSetting(param1);
        if (_loc3_) {
            _loc2_ = !!DateUtil.isNight() ? int(_loc3_.nightId) : int(_loc3_.dayId);
        }
        return _loc2_;
    }
}
}

class MapSetting {


    public var dayId:uint;

    public var nightId:uint;

    public var change:Boolean;

    public function MapSetting(param1:uint, param2:uint, param3:Boolean) {
        super();
        this.dayId = param1;
        this.nightId = param2;
        this.change = param3;
    }
}
