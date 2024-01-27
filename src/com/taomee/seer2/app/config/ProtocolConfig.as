package com.taomee.seer2.app.config {
import com.taomee.seer2.app.debugTools.ParameterInfo;
import com.taomee.seer2.app.debugTools.ProtocolInfo;

import org.taomee.ds.HashMap;

public class ProtocolConfig {

    private static var ProtocolClass:Class = ProtocolConfig_ProtocolClass;

    private static var _protocolXml:XML;

    private static var _protocolMap:HashMap;

    {
        initialize();
    }

    public function ProtocolConfig() {
        super();
    }

    private static function initialize():void {
        _protocolMap = new HashMap();
        _protocolXml = XML(new ProtocolClass());
        parseProtocol(_protocolXml);
    }

    private static function parseProtocol(param1:XML):void {
        var _loc3_:XML = null;
        var _loc4_:uint = 0;
        var _loc5_:String = null;
        var _loc6_:String = null;
        var _loc7_:Boolean = false;
        var _loc8_:Boolean = false;
        var _loc9_:ProtocolInfo = null;
        var _loc2_:XMLList = param1.descendants("Protocol");
        for each(_loc3_ in _loc2_) {
            _loc4_ = parseUint(_loc3_, "ID");
            _loc5_ = parseString(_loc3_, "Name");
            _loc6_ = parseString(_loc3_, "Description");
            _loc7_ = parseBool(_loc3_, "HaveRequest");
            _loc8_ = parseBool(_loc3_, "HaveReturn");
            _loc9_ = new ProtocolInfo(_loc4_, _loc5_, _loc6_, _loc7_, _loc8_);
            if (_loc7_) {
                _loc9_.requestPack = new Vector.<ParameterInfo>();
                parseParameter(_loc3_.RequestPack[0], _loc9_.requestPack);
            }
            if (_loc8_) {
                _loc9_.returnPack = new Vector.<ParameterInfo>();
                parseParameter(_loc3_.ReturnPack[0], _loc9_.returnPack);
            }
            _protocolMap.add(_loc4_, _loc9_);
        }
    }

    private static function parseParameter(param1:XML, param2:Vector.<ParameterInfo>):void {
        var _loc4_:XML = null;
        var _loc5_:uint = 0;
        var _loc6_:String = null;
        var _loc7_:String = null;
        var _loc8_:Boolean = false;
        var _loc9_:uint = 0;
        var _loc10_:uint = 0;
        var _loc11_:String = null;
        var _loc12_:ParameterInfo = null;
        var _loc3_:XMLList = param1.children();
        for each(_loc4_ in _loc3_) {
            _loc5_ = parseUint(_loc4_, "PID");
            _loc6_ = parseString(_loc4_, "Name");
            _loc7_ = parseString(_loc4_, "Type");
            _loc8_ = parseBool(_loc4_, "IsArray");
            _loc9_ = parseUint(_loc4_, "Length");
            _loc10_ = parseUint(_loc4_, "FixedLen");
            _loc11_ = parseString(_loc4_, "Description");
            _loc12_ = new ParameterInfo(_loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_);
            param2.push(_loc12_);
            if (_loc7_ == "struct") {
                _loc12_.structList = new Vector.<ParameterInfo>();
                parseParameter(_loc4_, _loc12_.structList);
            }
        }
    }

    private static function parseUint(param1:XML, param2:String, param3:int = 0):uint {
        var _loc4_:String;
        if ((_loc4_ = String(param1.attribute(param2))) == "") {
            return param3;
        }
        return uint(_loc4_);
    }

    private static function parseString(param1:XML, param2:String, param3:String = ""):String {
        var _loc4_:String;
        if ((_loc4_ = String(param1.attribute(param2))) == "") {
            _loc4_ = param3;
        }
        return _loc4_;
    }

    private static function parseBool(param1:XML, param2:String, param3:Boolean = false):Boolean {
        var _loc4_:String;
        if ((_loc4_ = String(param1.attribute(param2))) == "") {
            return param3;
        }
        if (_loc4_ == "0") {
            return false;
        }
        return true;
    }

    public static function getProtocol(param1:uint):ProtocolInfo {
        if (_protocolMap.containsKey(param1)) {
            return _protocolMap.getValue(param1);
        }
        return null;
    }
}
}
