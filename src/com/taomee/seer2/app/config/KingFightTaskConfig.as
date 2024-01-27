package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.KingFightTaskInfo;

import org.taomee.ds.HashMap;

public class KingFightTaskConfig {

    private static var _xmlClass:Class = KingFightTaskConfig__xmlClass;

    private static var _xml:XML;

    private static var _dayInfoList:Vector.<KingFightTaskInfo>;

    private static var _forInfoList:Vector.<KingFightTaskInfo>;

    private static var _map:HashMap = new HashMap();

    public static var dayList:Array = [];

    public static var forList:Array = [];

    public static var swapList:Array = [];

    {
        setup();
    }

    public function KingFightTaskConfig() {
        super();
    }

    public static function setup():void {
        var _loc2_:KingFightTaskInfo = null;
        var _loc3_:XML = null;
        var _loc4_:KingFightTaskInfo = null;
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
        var _loc18_:int = 0;
        var _loc19_:String = null;
        var _loc20_:Array = null;
        var _loc21_:Vector.<uint> = null;
        var _loc22_:String = null;
        var _loc23_:Array = null;
        var _loc24_:Vector.<uint> = null;
        _xml = XML(new _xmlClass());
        dayList = String(_xml.attribute("dayList")).split(",");
        forList = String(_xml.attribute("forList")).split(",");
        swapList = String(_xml.attribute("swapList")).split(",");
        _forInfoList = Vector.<KingFightTaskInfo>([]);
        var _loc1_:XMLList = _xml.descendants("forItem");
        for each(_loc3_ in _loc1_) {
            _loc2_ = new KingFightTaskInfo();
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
        _dayInfoList = Vector.<KingFightTaskInfo>([]);
        _loc1_ = _xml.descendants("dayItem");
        for each(_loc3_ in _loc1_) {
            _loc4_ = new KingFightTaskInfo();
            _loc16_ = int(_loc3_.attribute("index"));
            _loc17_ = String(_loc3_.attribute("tip"));
            _loc18_ = int(_loc3_.attribute("totalWin"));
            _loc20_ = (_loc19_ = String(_loc3_.attribute("itemList"))).split(",");
            _loc21_ = Vector.<uint>([]);
            _loc11_ = 0;
            while (_loc11_ < _loc20_.length) {
                _loc21_.push(uint(_loc20_[_loc11_]));
                _loc11_++;
            }
            _loc23_ = (_loc22_ = String(_loc3_.attribute("itemCount"))).split(",");
            _loc24_ = Vector.<uint>([]);
            _loc15_ = 0;
            while (_loc15_ < _loc13_.length) {
                _loc24_.push(uint(_loc23_[_loc15_]));
                _loc15_++;
            }
            _loc4_.type = "day";
            _loc4_.index = _loc16_;
            _loc4_.tip = _loc17_;
            _loc4_.totalWin = _loc18_;
            _loc4_.countList = _loc24_;
            _loc4_.itemList = _loc21_;
            _dayInfoList.push(_loc4_);
        }
        _forInfoList.sort(forSort);
        _dayInfoList.sort(daySort);
    }

    private static function rankingSort(param1:KingFightTaskInfo, param2:KingFightTaskInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }

    private static function daySort(param1:KingFightTaskInfo, param2:KingFightTaskInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }

    private static function forSort(param1:KingFightTaskInfo, param2:KingFightTaskInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }

    public static function getForInfoVec():Vector.<KingFightTaskInfo> {
        if (_forInfoList.length < 1) {
            return null;
        }
        return _forInfoList;
    }

    public static function getDayInfoVec():Vector.<KingFightTaskInfo> {
        if (_dayInfoList.length < 1) {
            return null;
        }
        return _dayInfoList;
    }
}
}
