package com.taomee.seer2.app.manager {
import flash.events.*;
import flash.net.*;

public class StatisticsManager2 {

    private static const dirtyKeyList:Array = ["=", ":", ",", ";", ".", "|", "\t"];

    private static var _gameId:int = 0;


    public function StatisticsManager2() {
        super();
    }

    public static function setup(param1:int):void {
        _gameId = param1;
    }

    public static function sendHttpStat(param1:String, param2:String, param3:String = null, param4:int = 0):void {
        var _loc5_:String = null;
        var _loc6_:* = encodeURI(replaceKey(param1));
        var _loc7_:* = encodeURI(replaceKey(param2));
        var _loc8_:* = "http://newmisc.taomee.com/misc.js?gameid=" + _gameId + "&stid=" + _loc6_ + "&sstid=" + _loc7_;
        if (param4) {
            _loc8_ += "&uid=" + param4;
        }
        if (param3) {
            _loc5_ = encodeURI(replaceKey(param3));
            _loc8_ += "&item=" + _loc5_ + "&itemlen=" + _loc5_.length;
        }
        _loc8_ += "&stidlen=" + _loc6_.length + "&sstidlen=" + _loc7_.length;
        send(_loc8_);
    }

    public static function sentHttpValueStat(param1:String, param2:uint = 1):void {
        send("http://newmisc.taomee.com/misc.txt?type=" + param1 + "&count=" + param2);
    }

    public static function send(param1:String):void {
        var _loc2_:* = new URLLoader();
        addLoaderEvent(_loc2_);
        _loc2_.load(new URLRequest(param1));
    }

    private static function addLoaderEvent(param1:URLLoader):void {
        param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        param1.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        param1.addEventListener(Event.COMPLETE, completeHandler);
    }

    private static function removeLoaderEvent(param1:URLLoader):void {
        param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        param1.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        param1.removeEventListener(Event.COMPLETE, completeHandler);
    }

    private static function securityErrorHandler(param1:SecurityErrorEvent):void {
        var _loc2_:* = param1.target as URLLoader;
        removeLoaderEvent(_loc2_);
    }

    private static function ioErrorHandler(param1:IOErrorEvent):void {
        var _loc2_:* = param1.target as URLLoader;
        removeLoaderEvent(_loc2_);
    }

    private static function completeHandler(param1:Event):void {
        var _loc2_:* = param1.target as URLLoader;
        _loc2_.close();
        removeLoaderEvent(_loc2_);
    }

    public static function replaceKey(param1:String):String {
        var _loc2_:String = null;
        for each(_loc2_ in dirtyKeyList) {
            if (param1.indexOf(_loc2_) >= 0) {
                param1 = replace(param1, _loc2_, "_");
            }
        }
        return param1;
    }

    private static function replace(param1:String, param2:String, param3:String):String {
        var _loc4_:Number = NaN;
        var _loc5_:* = new String();
        var _loc6_:Boolean = false;
        var _loc7_:* = param1.length;
        var _loc8_:* = param2.length;
        var _loc9_:Number = 0;
        while (_loc9_ < _loc7_) {
            if (param1.charAt(_loc9_) == param2.charAt(0)) {
                _loc6_ = true;
                _loc4_ = 0;
                while (_loc4_ < _loc8_) {
                    if (param1.charAt(_loc9_ + _loc4_) != param2.charAt(_loc4_)) {
                        _loc6_ = false;
                        break;
                    }
                    _loc4_ += 1;
                }
                if (_loc6_) {
                    _loc5_ += param3;
                    _loc9_ += _loc8_ - 1;
                }
            }
            _loc5_ += param1.charAt(_loc9_);
            _loc9_ += 1;
        }
        return _loc5_;
    }
}
}
