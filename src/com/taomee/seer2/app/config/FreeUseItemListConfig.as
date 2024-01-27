package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.FreeUseItemInfo;

public class FreeUseItemListConfig {

    private static var _xmlClass:Class = FreeUseItemListConfig__xmlClass;

    private static var _xml:XML;

    private static var _infoVec:Vector.<FreeUseItemInfo>;

    private static var _timeStr:String;

    {
        setup();
    }

    public function FreeUseItemListConfig() {
        super();
    }

    public static function setup():void {
        var _loc1_:FreeUseItemInfo = null;
        var _loc3_:Array = null;
        var _loc4_:Array = null;
        var _loc5_:int = 0;
        var _loc6_:XML = null;
        _xml = XML(new _xmlClass());
        _infoVec = Vector.<FreeUseItemInfo>([]);
        var _loc2_:XMLList = _xml.descendants("item");
        for each(_loc6_ in _loc2_) {
            _loc1_ = new FreeUseItemInfo();
            _loc1_.idRuleList = [];
            _loc3_ = String(_loc6_.attribute("id")).split(";");
            _loc5_ = 0;
            while (_loc5_ < _loc3_.length) {
                (_loc4_ = (_loc3_[_loc5_] as String).split(",")).push([uint(_loc4_[0]), int(_loc4_[1])]);
                _loc1_.idRuleList.push(_loc4_);
                _loc5_++;
            }
            _loc3_ = String(_loc6_.attribute("miBuyType")).split(",");
            _loc1_.miBuyType = [];
            _loc1_.miBuyType.push(int(_loc3_[0]), Boolean(int(_loc3_[1])), Boolean(int(_loc3_[2])));
            _loc1_.tip0 = String(_loc6_.attribute("tip0"));
            _loc1_.tip1 = String(_loc6_.attribute("tip1"));
            _loc1_.tip2 = String(_loc6_.attribute("tip2"));
            _infoVec.push(_loc1_);
        }
    }

    public static function getInfoVec():Vector.<FreeUseItemInfo> {
        return _infoVec;
    }
}
}
