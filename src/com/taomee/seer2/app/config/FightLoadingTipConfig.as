package com.taomee.seer2.app.config {
public class FightLoadingTipConfig {

    private static var _xmlClass:Class = FightLoadingTipConfig__xmlClass;

    private static var _configXML:XML;

    private static var arr:Array;

    {
        initialize();
    }

    public function FightLoadingTipConfig() {
        super();
    }

    private static function initialize():void {
        arr = new Array();
        setup();
    }

    private static function setup():void {
        var _loc2_:XML = null;
        _configXML = XML(new _xmlClass());
        var _loc1_:XMLList = _configXML.descendants("tip");
        for each(_loc2_ in _loc1_) {
            arr.push(_loc2_.@txt);
        }
    }

    public static function getTipList():Array {
        return arr;
    }
}
}
