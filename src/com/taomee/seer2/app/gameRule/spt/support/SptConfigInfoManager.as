package com.taomee.seer2.app.gameRule.spt.support {
public class SptConfigInfoManager {

    private static var _xmlClass:Class = SptConfigInfoManager__xmlClass;

    private static var _xml:XML;

    public static var bossInfoVec:Vector.<SptBossInfo>;

    {
        setup();
    }

    public function SptConfigInfoManager() {
        super();
    }

    private static function setup():void {
        var _loc2_:XML = null;
        var _loc3_:SptBossInfo = null;
        bossInfoVec = new Vector.<SptBossInfo>();
        _xml = XML(new _xmlClass());
        var _loc1_:XMLList = _xml.descendants("Boss");
        for each(_loc2_ in _loc1_) {
            _loc3_ = new SptBossInfo();
            _loc3_.id = _loc2_.attribute("BossID");
            _loc3_.level = _loc2_.attribute("BossLV");
            bossInfoVec.push(_loc3_);
        }
    }

    public static function getSptBossLevel(param1:uint):uint {
        var _loc3_:SptBossInfo = null;
        var _loc2_:uint = 0;
        for each(_loc3_ in bossInfoVec) {
            if (_loc3_.id == param1) {
                _loc2_ = _loc3_.level;
            }
        }
        return _loc2_;
    }
}
}
