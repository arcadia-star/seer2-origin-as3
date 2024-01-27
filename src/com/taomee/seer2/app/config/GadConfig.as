package com.taomee.seer2.app.config {
import org.taomee.ds.HashMap;

public class GadConfig {

    private static var _xmlClass:Class = GadConfig__xmlClass;

    private static var _configXML:XML;

    private static var _map:HashMap;

    private static var _map1:HashMap;

    {
        initialize();
    }

    public function GadConfig() {
        super();
    }

    private static function initialize():void {
        _map = new HashMap();
        _map1 = new HashMap();
        setup();
    }

    private static function setup():void {
        var _loc2_:XML = null;
        _configXML = XML(new _xmlClass());
        var _loc1_:XMLList = _configXML.descendants("gad");
        for each(_loc2_ in _loc1_) {
            initXML(_loc2_);
            storeXml(_loc2_);
        }
    }

    private static function initXML(param1:XML):void {
        var _loc3_:Array = null;
        var _loc2_:uint = uint(param1.@itemId);
        if (_map.containsKey(_loc2_) == false) {
            _loc3_ = [uint(param1.@petId), uint(param1.@swapId)];
            _map.add(_loc2_, _loc3_);
        }
    }

    private static function storeXml(param1:XML):void {
        var _loc2_:uint = uint(param1.@petId);
        if (_map1.containsKey(_loc2_) == false) {
            if (uint(param1.@itemId) >= 200401 && uint(param1.@itemId) < 204999) {
                _map1.add(_loc2_, uint(param1.@itemId));
            }
        }
    }

    public static function formIdGetGadInfo(param1:uint):Array {
        return _map.getValue(param1);
    }

    public static function getPetDecorationId(param1:uint):uint {
        return _map1.getValue(param1);
    }
}
}
