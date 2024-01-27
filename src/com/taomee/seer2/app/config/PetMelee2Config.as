package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.PetMeleeActivityInfo;
import com.taomee.seer2.app.config.info.PetMeleeRankingInfo;
import com.taomee.seer2.app.config.info.PetMeleeWinInfo;

import org.taomee.ds.HashMap;

public class PetMelee2Config {

    private static var _xmlClass:Class = PetMelee2Config__xmlClass;

    private static var _xml:XML;

    private static var _petMellRankingInfoList:Vector.<PetMeleeRankingInfo>;

    private static var _petMellWinInfoList:Vector.<PetMeleeWinInfo>;

    private static var _petMellActivityInfoList:Vector.<PetMeleeActivityInfo>;

    private static var _map:HashMap = new HashMap();

    private static var _content:String;

    {
        setup();
    }

    public function PetMelee2Config() {
        super();
    }

    public static function setup():void {
        var _loc2_:PetMeleeRankingInfo = null;
        var _loc3_:XML = null;
        var _loc4_:PetMeleeWinInfo = null;
        var _loc5_:PetMeleeActivityInfo = null;
        var _loc6_:int = 0;
        var _loc7_:String = null;
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
        var _loc19_:int = 0;
        var _loc20_:String = null;
        var _loc21_:Array = null;
        var _loc22_:Vector.<uint> = null;
        var _loc23_:int = 0;
        var _loc24_:String = null;
        var _loc25_:Array = null;
        var _loc26_:Vector.<uint> = null;
        var _loc27_:int = 0;
        var _loc28_:int = 0;
        var _loc29_:String = null;
        var _loc30_:String = null;
        var _loc31_:String = null;
        var _loc32_:Array = null;
        var _loc33_:Vector.<uint> = null;
        var _loc34_:int = 0;
        var _loc35_:String = null;
        var _loc36_:Array = null;
        var _loc37_:Vector.<uint> = null;
        var _loc38_:int = 0;
        _xml = XML(new _xmlClass());
        _petMellRankingInfoList = Vector.<PetMeleeRankingInfo>([]);
        _petMellWinInfoList = Vector.<PetMeleeWinInfo>([]);
        _petMellActivityInfoList = Vector.<PetMeleeActivityInfo>([]);
        var _loc1_:XMLList = _xml.descendants("title");
        _content = String(_loc1_[0].attribute("content"));
        _loc1_ = _xml.descendants("ranking");
        for each(_loc3_ in _loc1_) {
            _loc2_ = new PetMeleeRankingInfo();
            _loc6_ = int(_loc3_.attribute("index"));
            _loc7_ = String(_loc3_.attribute("tip"));
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
            _loc2_.ranking = _loc6_;
            _loc2_.itemList = _loc10_;
            _loc2_.countList = _loc14_;
            _map.add(_loc6_, _loc2_);
            _petMellRankingInfoList.push(_loc2_);
        }
        _loc1_ = _xml.descendants("win");
        for each(_loc3_ in _loc1_) {
            _loc4_ = new PetMeleeWinInfo();
            _loc16_ = int(_loc3_.attribute("index"));
            _loc17_ = String(_loc3_.attribute("tip"));
            _loc18_ = int(_loc3_.attribute("lastWin"));
            _loc19_ = int(_loc3_.attribute("totalWin"));
            _loc21_ = (_loc20_ = String(_loc3_.attribute("itemList"))).split(",");
            _loc22_ = Vector.<uint>([]);
            _loc23_ = 0;
            while (_loc23_ < _loc21_.length) {
                _loc22_.push(uint(_loc21_[_loc23_]));
                _loc23_++;
            }
            _loc25_ = (_loc24_ = String(_loc3_.attribute("itemCount"))).split(",");
            _loc26_ = Vector.<uint>([]);
            _loc27_ = 0;
            while (_loc27_ < _loc25_.length) {
                _loc26_.push(uint(_loc25_[_loc27_]));
                _loc27_++;
            }
            _loc4_.index = _loc16_;
            _loc4_.tip = _loc17_;
            _loc4_.lastWin = _loc18_;
            _loc4_.totalWin = _loc19_;
            _loc4_.countList = _loc26_;
            _loc4_.itemList = _loc22_;
            _petMellWinInfoList.push(_loc4_);
        }
        _loc1_ = _xml.descendants("activity");
        for each(_loc3_ in _loc1_) {
            _loc5_ = new PetMeleeActivityInfo();
            _loc28_ = int(_loc3_.attribute("index"));
            _loc29_ = String(_loc3_.attribute("title"));
            _loc30_ = String(_loc3_.attribute("content"));
            _loc32_ = (_loc31_ = String(_loc3_.attribute("itemList"))).split(",");
            _loc33_ = Vector.<uint>([]);
            _loc34_ = 0;
            while (_loc34_ < _loc32_.length) {
                _loc33_.push(uint(_loc32_[_loc34_]));
                _loc34_++;
            }
            _loc36_ = (_loc35_ = String(_loc3_.attribute("itemCount"))).split(",");
            _loc37_ = Vector.<uint>([]);
            _loc38_ = 0;
            while (_loc38_ < _loc36_.length) {
                _loc37_.push(uint(_loc36_[_loc38_]));
                _loc38_++;
            }
            _loc5_.index = _loc28_;
            _loc5_.title = _loc29_;
            _loc5_.content = _loc30_;
            _loc5_.itemList = _loc33_;
            _loc5_.itemCount = _loc37_;
            _petMellActivityInfoList.push(_loc5_);
        }
        _petMellRankingInfoList.sort(rankingSort);
        _petMellWinInfoList.sort(winSort);
        _petMellActivityInfoList.sort(activitySort);
    }

    private static function rankingSort(param1:PetMeleeRankingInfo, param2:PetMeleeRankingInfo):int {
        if (param1.ranking > param2.ranking) {
            return 1;
        }
        if (param1.ranking < param2.ranking) {
            return -1;
        }
        return 0;
    }

    private static function activitySort(param1:PetMeleeActivityInfo, param2:PetMeleeActivityInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }

    private static function winSort(param1:PetMeleeWinInfo, param2:PetMeleeWinInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }

    public static function getRankingInfoVec():Vector.<PetMeleeRankingInfo> {
        if (_petMellRankingInfoList.length < 1) {
            return null;
        }
        return _petMellRankingInfoList;
    }

    public static function getActivityInfoVec():Vector.<PetMeleeActivityInfo> {
        if (_petMellActivityInfoList.length < 1) {
            return null;
        }
        return _petMellActivityInfoList;
    }

    public static function getWinInfoVec():Vector.<PetMeleeWinInfo> {
        if (_petMellWinInfoList.length < 1) {
            return null;
        }
        return _petMellWinInfoList;
    }

    public static function getRankingInfo(param1:int):PetMeleeRankingInfo {
        return _map.getValue(param1);
    }

    public static function getTitle():String {
        return _content;
    }
}
}
