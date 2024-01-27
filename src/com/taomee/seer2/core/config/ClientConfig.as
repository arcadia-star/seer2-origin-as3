package com.taomee.seer2.core.config {
public class ClientConfig {

    private static const PRODUCT_NAME:String = "seer2";

    private static const PRODUCT_ID:uint = 10;

    private static var _isDebug:Boolean = false;

    private static var _isLocal:Boolean = false;

    private static var _configXml:XML;

    private static var _rootURL:String = "";

    public static const timeRate:uint = 33;

    public static var isInitComplete:Boolean = false;


    public function ClientConfig() {
        super();
    }

    public static function setXML(param1:XML):void {
        _configXml = param1;
    }

    public static function setDebug(param1:Boolean):void {
        _isDebug = param1;
    }

    public static function setRootURL(param1:String):void {
        if (param1 == null) {
            param1 = "";
        }
        _rootURL = param1;
    }

    public static function setLocal(param1:Boolean):void {
        _isLocal = param1;
    }

    public static function get isLocal():Boolean {
        return _isLocal;
    }

    public static function get productName():String {
        if (_configXml.@name != null && _configXml.@name != "" && _configXml.@name != undefined) {
            return _configXml.@name;
        }
        return PRODUCT_NAME;
    }

    public static function get productID():uint {
        if (_configXml.@gid != null && _configXml.@gid != "" && _configXml.@gid != undefined) {
            return uint(_configXml.@gid);
        }
        return PRODUCT_ID;
    }

    public static function get isDebug():Boolean {
        return _isDebug;
    }

    public static function get rootURL():String {
        return _rootURL;
    }

    public static function get telDeputizeIP():String {
        return String(_configXml.telDeputize.@ip);
    }

    public static function get telDeputizePort():uint {
        return uint(_configXml.telDeputize.@port);
    }

    public static function get cncDeputizeIP():String {
        return String(_configXml.cncDeputize.@ip);
    }

    public static function get cncDeputizePort():uint {
        return uint(_configXml.cncDeputize.@port);
    }
}
}
