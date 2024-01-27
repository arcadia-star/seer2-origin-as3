package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.FindPetInfo;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.scene.SceneManager;

import org.taomee.ds.HashMap;

public class FindPetConfig {

    private static var _xmlClass:Class = FindPetConfig__xmlClass;

    private static var _configXML:XML;

    private static var infoMap:HashMap;

    private static var mapPetMap:HashMap;

    public static var startTime:uint;

    public static var endTime:uint;

    {
        initialize();
    }

    public function FindPetConfig() {
        super();
    }

    public static function getCreateInfo(param1:int):FindPetInfo {
        var _loc7_:FindPetInfo = null;
        var _loc9_:String = null;
        var _loc10_:Array = null;
        var _loc11_:int = 0;
        var _loc2_:Array = mapPetMap.getValue(param1) as Array;
        if (!_loc2_) {
            return null;
        }
        var _loc3_:uint = uint(TimeManager.getPrecisionServerTime());
        var _loc5_:String;
        var _loc4_:Date;
        if ((_loc5_ = (_loc4_ = new Date(_loc3_ * 1000)).minutes.toString()).length == 1) {
            _loc5_ = "0" + _loc5_;
        }
        var _loc6_:int = int(String(_loc4_.hours) + _loc5_);
        var _loc8_:int = 0;
        while (_loc8_ < _loc2_.length) {
            _loc9_ = param1 + "_" + _loc2_[_loc8_];
            _loc7_ = infoMap.getValue(_loc9_) as FindPetInfo;
            if (_loc3_ < _loc7_.end && _loc3_ > _loc7_.start) {
                _loc10_ = _loc7_.timeList[_loc4_.day];
                _loc11_ = 0;
                while (_loc11_ < _loc10_.length) {
                    if (_loc6_ > _loc10_[_loc11_]["start"] && _loc6_ < _loc10_[_loc11_]["end"]) {
                        return _loc7_;
                    }
                    _loc11_++;
                }
            }
            _loc8_++;
        }
        return null;
    }

    private static function initialize():void {
        var _loc2_:FindPetInfo = null;
        var _loc6_:XML = null;
        var _loc7_:Array = null;
        var _loc8_:XMLList = null;
        var _loc9_:uint = 0;
        var _loc10_:uint = 0;
        var _loc11_:int = 0;
        var _loc12_:Object = null;
        _configXML = XML(new _xmlClass());
        var _loc1_:XMLList = _configXML.descendants("act");
        infoMap = new HashMap();
        mapPetMap = new HashMap();
        var _loc3_:Date = new Date();
        var _loc4_:Array = String(_configXML.@start).split("_");
        _loc3_.fullYear = int(_loc4_[0]);
        _loc3_.month = int(_loc4_[1]) - 1;
        _loc3_.date = int(_loc4_[2]);
        _loc3_.hours = int(_loc4_[3]);
        _loc3_.minutes = int(_loc4_[4]);
        startTime = uint(_loc3_.getTime() / 1000);
        var _loc5_:Array = String(_configXML.@end).split("_");
        _loc3_.fullYear = int(_loc5_[0]);
        _loc3_.month = int(_loc5_[1]) - 1;
        _loc3_.date = int(_loc5_[2]);
        _loc3_.hours = int(_loc5_[3]);
        _loc3_.minutes = int(_loc5_[4]);
        endTime = uint(_loc3_.getTime() / 1000);
        for each(_loc6_ in _loc1_) {
            _loc2_ = new FindPetInfo();
            _loc2_.petId = int(_loc6_.@petId);
            _loc2_.fightId = int(_loc6_.@fightId);
            _loc2_.probabilityId = int(_loc6_.@probabilityId);
            _loc2_.mapId = int(_loc6_.@mapId);
            _loc2_.lev = int(_loc6_.@lev);
            _loc4_ = String(_loc6_.@start).split("_");
            _loc3_.fullYear = int(_loc4_[0]);
            _loc3_.month = int(_loc4_[1]) - 1;
            _loc3_.date = int(_loc4_[2]);
            _loc3_.hours = int(_loc4_[3]);
            _loc3_.minutes = int(_loc4_[4]);
            _loc2_.start = uint(_loc3_.getTime() / 1000);
            _loc5_ = String(_loc6_.@end).split("_");
            _loc3_.fullYear = int(_loc5_[0]);
            _loc3_.month = int(_loc5_[1]) - 1;
            _loc3_.date = int(_loc5_[2]);
            _loc3_.hours = int(_loc5_[3]);
            _loc3_.minutes = int(_loc5_[4]);
            _loc2_.end = uint(_loc3_.getTime() / 1000);
            if (!(_loc7_ = mapPetMap.getKey(_loc2_.mapId) as Array)) {
                _loc7_ = [];
                mapPetMap.add(_loc2_.mapId, _loc7_);
            }
            if (_loc7_.indexOf(_loc2_.petId) == -1) {
                _loc7_.push(_loc2_.petId);
            }
            _loc2_.timeList = new Array(7);
            _loc8_ = _loc6_.descendants("time");
            for each(_loc6_ in _loc8_) {
                _loc9_ = uint(_loc6_.@start);
                _loc10_ = uint(_loc6_.@end);
                _loc11_ = int(_loc6_.@day);
                if (!_loc2_.timeList[_loc11_]) {
                    _loc2_.timeList[_loc11_] = [];
                }
                (_loc12_ = new Object()).start = _loc9_;
                _loc12_.end = _loc10_;
                _loc2_.timeList[_loc11_].push(_loc12_);
            }
            infoMap.add(_loc2_.mapId + "_" + _loc2_.petId, _loc2_);
        }
    }

    public static function getMapFindPetinfo():FindPetInfo {
        return infoMap.getValue(SceneManager.active.mapID) as FindPetInfo;
    }
}
}
