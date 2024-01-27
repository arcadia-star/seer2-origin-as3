package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.YiteFightSwapInfo;

public class YiteFightSwap {

    private static var _xmlClass:Class = YiteFightSwap__xmlClass;

    private static var _xml:XML;

    private static var _infoVec:Array;

    private static var _petInfoVec:Array;

    private static var _petGadVec:Array;

    {
        setup();
    }

    public function YiteFightSwap() {
        super();
    }

    public static function setup():void {
        var _loc1_:YiteFightSwapInfo = null;
        var _loc3_:XML = null;
        var _loc4_:uint = 0;
        var _loc5_:String = null;
        var _loc6_:uint = 0;
        var _loc7_:uint = 0;
        var _loc8_:uint = 0;
        var _loc9_:uint = 0;
        _xml = XML(new _xmlClass());
        _infoVec = [];
        _petInfoVec = [];
        _petGadVec = [];
        var _loc2_:XMLList = _xml.descendants("swap");
        for each(_loc3_ in _loc2_) {
            _loc1_ = new YiteFightSwapInfo();
            _loc4_ = uint(_loc3_.attribute("type"));
            _loc5_ = String(_loc3_.attribute("name"));
            _loc6_ = uint(_loc3_.attribute("swapCount"));
            _loc7_ = uint(_loc3_.attribute("id"));
            _loc8_ = uint(_loc3_.attribute("isPet"));
            _loc9_ = uint(_loc3_.attribute("swapID"));
            _loc1_.type = _loc4_;
            _loc1_.name = _loc5_;
            _loc1_.swapCount = _loc6_;
            _loc1_.id = _loc7_;
            _loc1_.isPet = _loc8_;
            _loc1_.swapId = _loc9_;
            if (_loc4_ == 2) {
                _infoVec.push(_loc1_);
            } else if (_loc4_ == 1) {
                _petInfoVec.push(_loc1_);
            } else if (_loc4_ == 3) {
                _petGadVec.push(_loc1_);
            }
        }
    }

    public static function getInfoVec(param1:uint):Array {
        if (param1 == 1) {
            return _petInfoVec;
        }
        if (param1 == 2) {
            return _infoVec;
        }
        if (param1 == 3) {
            return _petGadVec;
        }
        return null;
    }
}
}
