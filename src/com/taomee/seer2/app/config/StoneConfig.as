package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.StoneInfo;

import org.taomee.ds.HashMap;

public class StoneConfig {

    private static var _xmlClass:Class = StoneConfig__xmlClass;

    private static var _configXML:XML;

    private static var _map:HashMap;

    private static var _minMap:HashMap;

    {
        initialize();
    }

    public function StoneConfig() {
        super();
    }

    private static function initialize():void {
        _map = new HashMap();
        _minMap = new HashMap();
        setup();
    }

    private static function setup():void {
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        var _loc4_:StoneInfo = null;
        var _loc5_:XML = null;
        var _loc6_:XMLList = null;
        _configXML = XML(new _xmlClass());
        var _loc1_:XMLList = _configXML.descendants("stoneTotal");
        for each(_loc5_ in _loc1_) {
            _loc4_ = new StoneInfo();
            _loc6_ = _loc5_.descendants("stone");
            _loc2_ = uint(_loc6_[0].@itemId);
            _loc3_ = uint(_loc6_[0].@petId);
            _loc4_.id = _loc2_;
            _loc4_.petId = _loc3_;
            _loc4_.list = initXML(_loc5_);
            _map.add(_loc2_, _loc4_);
        }
    }

    private static function initXML(param1:XML):Array {
        var _loc4_:Array = null;
        var _loc5_:uint = 0;
        var _loc6_:XML = null;
        var _loc2_:XMLList = param1.descendants("stone");
        var _loc3_:Array = [];
        for each(_loc6_ in _loc2_) {
            _loc4_ = [_loc5_ = uint(_loc6_.@itemId), uint(_loc6_.@decoratinId), uint(_loc6_.@petId), uint(_loc6_.@swapId)];
            _loc3_.push(_loc4_);
        }
        _minMap.add(_loc5_, _loc3_);
        return _loc3_;
    }

    public static function formIdGetStoneInfo(param1:uint):Array {
        return _minMap.getValue(param1);
    }

    public static function getInfo(param1:uint):StoneInfo {
        return _map.getValue(param1);
    }
}
}
