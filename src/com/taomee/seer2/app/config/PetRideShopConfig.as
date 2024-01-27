package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.PetRideShopInfo;

import org.taomee.ds.HashMap;

public class PetRideShopConfig {

    private static var _setting:Class = PetRideShopConfig__setting;

    private static var _infos:HashMap;


    public function PetRideShopConfig() {
        super();
    }

    public static function getInfoList():Vector.<PetRideShopInfo> {
        var _loc4_:PetRideShopInfo = null;
        var _loc1_:HashMap = getInfos();
        var _loc2_:Array = _loc1_.getValues();
        var _loc3_:Vector.<PetRideShopInfo> = new Vector.<PetRideShopInfo>();
        for each(_loc4_ in _loc2_) {
            _loc3_.push(_loc4_);
        }
        _loc3_.sort(sortFunction);
        return _loc3_;
    }

    public static function getMiBiList():Vector.<PetRideShopInfo> {
        var _loc4_:PetRideShopInfo = null;
        var _loc1_:HashMap = getInfos();
        var _loc2_:Array = _loc1_.getValues();
        var _loc3_:Vector.<PetRideShopInfo> = new Vector.<PetRideShopInfo>();
        for each(_loc4_ in _loc2_) {
            if (_loc4_.isCostMiBi == 1) {
                _loc3_.push(_loc4_);
            }
        }
        _loc3_.sort(sortFunction);
        return _loc3_;
    }

    public static function getFreeList():Vector.<PetRideShopInfo> {
        var _loc4_:PetRideShopInfo = null;
        var _loc1_:HashMap = getInfos();
        var _loc2_:Array = _loc1_.getValues();
        var _loc3_:Vector.<PetRideShopInfo> = new Vector.<PetRideShopInfo>();
        for each(_loc4_ in _loc2_) {
            if (_loc4_.isCostMiBi == 0) {
                _loc3_.push(_loc4_);
            }
        }
        _loc3_.sort(sortFunction);
        return _loc3_;
    }

    public static function getFreeChipIdByPetId(param1:int):int {
        var _loc2_:Vector.<PetRideShopInfo> = getFreeList();
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].petResourceId == param1) {
                return _loc2_[_loc3_].chipId;
            }
            _loc3_++;
        }
        return 0;
    }

    public static function getMiBiChipIdByPetId(param1:int):int {
        var _loc2_:Vector.<PetRideShopInfo> = getMiBiList();
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].petResourceId == param1) {
                return _loc2_[_loc3_].chipId;
            }
            _loc3_++;
        }
        return 0;
    }

    public static function getEquipIdByPetId(param1:int):int {
        var _loc2_:Vector.<PetRideShopInfo> = getInfoList();
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].petResourceId == param1) {
                return _loc2_[_loc3_].equipId;
            }
            _loc3_++;
        }
        return 0;
    }

    public static function isCanRidePet(param1:int):Boolean {
        var _loc2_:Vector.<PetRideShopInfo> = getInfoList();
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].petResourceId == param1) {
                return true;
            }
            _loc3_++;
        }
        return false;
    }

    public static function getSwapIdByItemId(param1:int):int {
        var _loc2_:Vector.<PetRideShopInfo> = getInfoList();
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].chipId == param1) {
                return _loc2_[_loc3_].swapId;
            }
            _loc3_++;
        }
        return 0;
    }

    public static function getEquipIdByChipBackId(param1:int):int {
        var _loc2_:Vector.<PetRideShopInfo> = getInfoList();
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].chipBackId == param1) {
                return _loc2_[_loc3_].equipId;
            }
            _loc3_++;
        }
        return 0;
    }

    public static function isRidePetEquip(param1:int):Boolean {
        var _loc2_:Vector.<PetRideShopInfo> = getInfoList();
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].equipId == param1) {
                return true;
            }
            _loc3_++;
        }
        return false;
    }

    public static function isRidePetBunch(param1:int):Boolean {
        var _loc2_:Vector.<PetRideShopInfo> = getInfoList();
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].bunchId == param1) {
                return true;
            }
            _loc3_++;
        }
        return false;
    }

    public static function isThisPetOfThisChip(param1:int, param2:int):Boolean {
        var _loc3_:Vector.<PetRideShopInfo> = getInfoList();
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_.length) {
            if (_loc3_[_loc4_].chipId == param1 && _loc3_[_loc4_].petResourceId == param2) {
                return true;
            }
            _loc4_++;
        }
        return false;
    }

    private static function getInfos():HashMap {
        if (_infos == null) {
            _infos = new HashMap();
            setUp();
        }
        return _infos;
    }

    private static function setUp():void {
        var _loc4_:XML = null;
        var _loc5_:PetRideShopInfo = null;
        var _loc1_:XML = XML(new _setting());
        var _loc2_:XMLList = _loc1_.child("pet");
        var _loc3_:int = _loc2_.length();
        var _loc6_:int = 0;
        while (_loc6_ < _loc3_) {
            _loc4_ = _loc2_[_loc6_];
            (_loc5_ = new PetRideShopInfo()).chipId = int(_loc4_.@chipId);
            _loc5_.chipBackId = int(_loc4_.@chipBackId);
            _loc5_.index = int(_loc4_.@index);
            _loc5_.petResourceId = int(_loc4_.@petResourceId);
            _loc5_.bunchId = int(_loc4_.@petBunchId);
            _loc5_.equipId = int(_loc4_.@equipId);
            _loc5_.chipName = String(_loc4_.@name);
            _loc5_.isCostMiBi = int(_loc4_.@mibi);
            _loc5_.swapId = int(_loc4_.@swapId);
            _loc5_.getPetType = String(_loc4_.@getPetType);
            _loc5_.whereToGet = String(_loc4_.@whereToGet);
            _infos.add(_loc5_.chipId, _loc5_);
            _loc6_++;
        }
    }

    private static function sortFunction(param1:PetRideShopInfo, param2:PetRideShopInfo):int {
        if (param1.index > param2.index) {
            return 1;
        }
        if (param1.index < param2.index) {
            return -1;
        }
        return 0;
    }
}
}
