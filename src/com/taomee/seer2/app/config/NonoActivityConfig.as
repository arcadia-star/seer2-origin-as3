package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.NonoActivityInfo;

import seer2.next.entry.DynConfig;

public class NonoActivityConfig {

    private static var _xmlClass:Class = NonoActivityConfig__xmlClass;

    private static var _xml:XML;

    private static var _nonoInfoVec:Vector.<NonoActivityInfo>;

    {
        setup();
    }

    public function NonoActivityConfig() {
        super();
    }

    public static function setup():void {
        loadConfig(DynConfig.nonoActivityConfigXML || XML(new _xmlClass()));
    }

    public static function loadConfig(xml:XML):void {
        var _loc1_:NonoActivityInfo = null;
        var _loc3_:XML = null;
        var _loc4_:String = null;
        var _loc5_:uint = 0;
        var _loc6_:String = null;
        var _loc7_:String = null;
        _xml = xml;
        _nonoInfoVec = Vector.<NonoActivityInfo>([]);
        var _loc2_:XMLList = _xml.descendants("activity");
        for each(_loc3_ in _loc2_) {
            _loc1_ = new NonoActivityInfo();
            _loc4_ = String(_loc3_.attribute("content"));
            _loc5_ = uint(_loc3_.attribute("isShowGo"));
            _loc6_ = String(_loc3_.attribute("goType"));
            _loc7_ = String(_loc3_.attribute("goContent"));
            _loc1_.content = _loc4_;
            _loc1_.isShowGo = _loc5_;
            _loc1_.goType = _loc6_;
            _loc1_.goContent = _loc7_;
            _nonoInfoVec.push(_loc1_);
        }
    }

    public static function getNonoInfoVec():Vector.<NonoActivityInfo> {
        if (_nonoInfoVec.length < 1) {
            return null;
        }
        return _nonoInfoVec;
    }
}
}
