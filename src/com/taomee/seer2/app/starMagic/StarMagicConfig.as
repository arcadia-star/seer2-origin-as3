package com.taomee.seer2.app.starMagic {
public class StarMagicConfig {

    private static var _xmlClass:Class = StarMagicConfig__xmlClass;

    private static var _xml:XML;

    private static var _starHunInfoVec:Vector.<StarInfo>;

    {
        setup();
    }

    public function StarMagicConfig() {
        super();
    }

    public static function setup():void {
        var _loc1_:StarInfo = null;
        var _loc3_:XML = null;
        var _loc4_:String = null;
        var _loc5_:uint = 0;
        var _loc6_:String = null;
        var _loc7_:String = null;
        var _loc8_:String = null;
        var _loc9_:String = null;
        var _loc10_:String = null;
        var _loc11_:String = null;
        var _loc12_:String = null;
        var _loc13_:uint = 0;
        var _loc14_:String = null;
        var _loc15_:Array = null;
        var _loc16_:Array = null;
        var _loc17_:int = 0;
        _xml = XML(new _xmlClass());
        _starHunInfoVec = Vector.<StarInfo>([]);
        var _loc2_:XMLList = _xml.descendants("runes");
        for each(_loc3_ in _loc2_) {
            _loc1_ = new StarInfo();
            _loc4_ = String(_loc3_.attribute("type"));
            _loc5_ = uint(_loc3_.attribute("max_lvl"));
            _loc6_ = String(_loc3_.attribute("name"));
            _loc7_ = String(_loc3_.attribute("value"));
            _loc8_ = String(_loc3_.attribute("lvl_cof"));
            _loc9_ = String(_loc3_.attribute("index"));
            _loc10_ = String(_loc3_.attribute("desc"));
            _loc11_ = String(_loc3_.attribute("needExp"));
            _loc12_ = String(_loc3_.attribute("effdesc"));
            _loc13_ = uint(_loc3_.attribute("buffSwf"));
            _loc14_ = String(_loc3_.attribute("effv"));
            _loc15_ = _loc11_.split(",");
            _loc1_.id = int(_loc9_);
            _loc1_.buffId = int(_loc9_);
            _loc1_.level_cof = int(_loc8_);
            _loc1_.maxLevel = int(_loc5_);
            _loc1_.sell_exp = int(_loc7_);
            _loc1_.type = int(_loc4_);
            _loc1_.nameT = _loc6_;
            _loc1_.nextExpArr = _loc15_;
            _loc1_.buffSwf = _loc13_;
            _loc1_.effdesc = _loc12_;
            _loc1_.desc = _loc10_.split(";");
            _loc15_ = _loc14_.split(";");
            _loc16_ = new Array();
            _loc17_ = 0;
            while (_loc17_ < _loc15_.length) {
                _loc16_.push(_loc15_[_loc17_].split(","));
                _loc17_++;
            }
            _loc1_.effvalue = _loc16_;
            _starHunInfoVec.push(_loc1_);
        }
    }

    public static function getInfoVec():Vector.<StarInfo> {
        if (_starHunInfoVec.length < 1) {
            return null;
        }
        return _starHunInfoVec;
    }

    public static function getInfo(param1:int, param2:int):StarInfo {
        if (_starHunInfoVec.length < 1) {
            return null;
        }
        var _loc3_:int = 0;
        while (_loc3_ < _starHunInfoVec.length) {
            if (_starHunInfoVec[_loc3_].id == param1 && _starHunInfoVec[_loc3_].type == param2) {
                return _starHunInfoVec[_loc3_];
            }
            _loc3_++;
        }
        return null;
    }

    public static function getInfoById(param1:int):StarInfo {
        if (_starHunInfoVec.length < 1) {
            return null;
        }
        var _loc2_:int = 0;
        while (_loc2_ < _starHunInfoVec.length) {
            if (_starHunInfoVec[_loc2_].id == param1) {
                return _starHunInfoVec[_loc2_];
            }
            _loc2_++;
        }
        return null;
    }
}
}
