package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.WinterSignInfo;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.net.parser.Parser_1142;

import org.taomee.ds.HashMap;

public class WinterSignConfig {

    private static var _xmlClass:Class = WinterSignConfig__xmlClass;

    private static var _xml:XML;

    private static var _dayInfoList:Vector.<WinterSignInfo>;

    private static var _forInfoList:Vector.<WinterSignInfo>;

    private static var _map:HashMap = new HashMap();

    public static var dayList:Array = [];

    public static var forList:Array = [];

    public static var swapList:Array = [];

    public static var startTime:Array;

    public static var endTime:Array;

    public static var miBuyList:Array;

    public static var freeSign:Array;

    public static var par:Parser_1142;

    public static var info:DayLimitListInfo;

    {
        setup();
    }

    public function WinterSignConfig() {
        super();
    }

    public static function setup():void {
        var _loc2_:WinterSignInfo = null;
        var _loc3_:XML = null;
        var _loc4_:WinterSignInfo = null;
        var _loc5_:int = 0;
        var _loc6_:String = null;
        var _loc7_:int = 0;
        var _loc8_:String = null;
        var _loc9_:Array = null;
        var _loc10_:Vector.<uint> = null;
        var _loc11_:int = 0;
        var _loc12_:String = null;
        var _loc13_:Array = null;
        var _loc14_:Vector.<uint> = null;
        var _loc15_:int = 0;
        var _loc16_:int = 0;
        var _loc17_:String = null;
        var _loc18_:String = null;
        var _loc19_:Array = null;
        var _loc20_:Vector.<uint> = null;
        var _loc21_:String = null;
        var _loc22_:Array = null;
        var _loc23_:Vector.<uint> = null;
        _xml = XML(new _xmlClass());
        startTime = String(_xml.attribute("startTime")).split("-");
        endTime = String(_xml.attribute("endTime")).split("-");
        dayList = String(_xml.attribute("dayList")).split(",");
        forList = String(_xml.attribute("forList")).split(",");
        swapList = String(_xml.attribute("swapList")).split(",");
        miBuyList = String(_xml.attribute("miBuyList")).split(",");
        freeSign = String(_xml.attribute("freeSign")).split(",");
        _forInfoList = Vector.<WinterSignInfo>([]);
        var _loc1_:XMLList = _xml.descendants("forItem");
        for each(_loc3_ in _loc1_) {
            _loc2_ = new WinterSignInfo();
            _loc5_ = int(_loc3_.attribute("index"));
            _loc6_ = String(_loc3_.attribute("tip"));
            _loc7_ = int(_loc3_.attribute("totalWin"));
            _loc9_ = (_loc8_ = String(_loc3_.attribute("itemList"))).split(",");
            _loc10_ = Vector.<uint>([]);
            _loc11_ = 0;
            while (_loc11_ < _loc9_.length) {
                _loc10_.push(uint(_loc9_[_loc11_]));
                _loc11_++;
            }
            _loc13_ = (_loc12_ = String(_loc3_.attribute("itemCount"))).split(",");
            _loc14_ = Vector.<uint>([]);
            _loc15_ = 0;
            while (_loc15_ < _loc13_.length) {
                _loc14_.push(uint(_loc13_[_loc15_]));
                _loc15_++;
            }
            _loc2_.type = "for";
            _loc2_.index = _loc5_;
            _loc2_.tip = _loc6_;
            _loc2_.totalWin = _loc7_;
            _loc2_.countList = _loc14_;
            _loc2_.itemList = _loc10_;
            _forInfoList.push(_loc2_);
        }
        _dayInfoList = Vector.<WinterSignInfo>([]);
        _loc1_ = _xml.descendants("dayItem");
        for each(_loc3_ in _loc1_) {
            _loc4_ = new WinterSignInfo();
            _loc16_ = int(_loc3_.attribute("index"));
            _loc17_ = String(_loc3_.attribute("tip"));
            _loc19_ = (_loc18_ = String(_loc3_.attribute("itemList"))).split(",");
            _loc20_ = Vector.<uint>([]);
            _loc11_ = 0;
            while (_loc11_ < _loc19_.length) {
                _loc20_.push(uint(_loc19_[_loc11_]));
                _loc11_++;
            }
            _loc22_ = (_loc21_ = String(_loc3_.attribute("itemCount"))).split(",");
            _loc23_ = Vector.<uint>([]);
            _loc15_ = 0;
            while (_loc15_ < _loc22_.length) {
                _loc23_.push(uint(_loc22_[_loc15_]));
                _loc15_++;
            }
            _loc4_.type = "day";
            _loc4_.index = _loc16_;
            _loc4_.tip = _loc17_;
            _loc4_.countList = _loc23_;
            _loc4_.itemList = _loc20_;
            _dayInfoList.push(_loc4_);
        }
        _forInfoList.sort(forSort);
        _dayInfoList.sort(daySort);
    }

    private static function rankingSort(param1:WinterSignInfo, param2:WinterSignInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }

    private static function daySort(param1:WinterSignInfo, param2:WinterSignInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }

    private static function forSort(param1:WinterSignInfo, param2:WinterSignInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }

    public static function getForInfoVec():Vector.<WinterSignInfo> {
        if (_forInfoList.length < 1) {
            return null;
        }
        return _forInfoList;
    }

    public static function getDayInfoVec():Vector.<WinterSignInfo> {
        if (_dayInfoList.length < 1) {
            return null;
        }
        return _dayInfoList;
    }
}
}
