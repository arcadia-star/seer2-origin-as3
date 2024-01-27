package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.LimitTimeItemInfo;

public class LimitTimeItemListConfig {

    private static var _xmlClass:Class = LimitTimeItemListConfig__xmlClass;

    private static var _xml:XML;

    private static var _infoVec:Vector.<LimitTimeItemInfo>;

    private static var _timeStr:String;

    {
        setup();
    }

    public function LimitTimeItemListConfig() {
        super();
    }

    public static function setup():void {
        var _loc1_:LimitTimeItemInfo = null;
        var _loc4_:XML = null;
        var _loc5_:uint = 0;
        var _loc6_:Array = null;
        var _loc7_:Array = null;
        var _loc8_:uint = 0;
        var _loc9_:uint = 0;
        var _loc10_:Number = NaN;
        var _loc11_:Number = NaN;
        var _loc12_:uint = 0;
        _xml = XML(new _xmlClass());
        _infoVec = Vector.<LimitTimeItemInfo>([]);
        var _loc2_:XMLList = _xml.descendants("item");
        var _loc3_:XMLList = _xml.descendants("title");
        _timeStr = (_loc3_[0] as XML).attribute("time").toString();
        for each(_loc4_ in _loc2_) {
            _loc1_ = new LimitTimeItemInfo();
            _loc5_ = uint(_loc4_.attribute("id"));
            _loc6_ = String(_loc4_.attribute("startTime")).split("_");
            _loc7_ = String(_loc4_.attribute("endTime")).split("_");
            _loc8_ = uint(_loc4_.attribute("limitCount"));
            _loc9_ = uint(_loc4_.attribute("isNew"));
            _loc10_ = Number(_loc4_.attribute("prevPrice"));
            _loc11_ = Number(_loc4_.attribute("currPrice"));
            _loc12_ = uint(_loc4_.attribute("shopId"));
            _loc1_.id = _loc5_;
            _loc1_.startTime = _loc6_;
            _loc1_.endTime = _loc7_;
            _loc1_.limitCount = _loc8_;
            _loc1_.isNew = _loc9_;
            _loc1_.prevPrice = _loc10_;
            _loc1_.currPrice = _loc11_;
            _loc1_.shopId = _loc12_;
            _infoVec.push(_loc1_);
        }
    }

    public static function getInfoVec():Vector.<LimitTimeItemInfo> {
        if (_infoVec.length < 1) {
            return null;
        }
        return _infoVec;
    }

    public static function getTitleStr():String {
        return _timeStr;
    }
}
}
