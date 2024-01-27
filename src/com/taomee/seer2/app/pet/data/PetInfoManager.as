package com.taomee.seer2.app.pet.data {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.PetEvolveConfig;
import com.taomee.seer2.app.config.pet.PetDefinition;
import com.taomee.seer2.app.gameRule.ring.RingSupport;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1259;
import com.taomee.seer2.app.pet.PetPowerUpdate;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.starMagic.StarInfo;
import com.taomee.seer2.app.utils.PetUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;

import flash.events.EventDispatcher;
import flash.utils.IDataInput;

import org.taomee.ds.HashMap;

public class PetInfoManager {

    private static const MAX_BAG_PET_COUNT:int = 6;

    private static var _petInfoMap:HashMap = new HashMap();

    private static var _petStorageInfoMap:HashMap = new HashMap();

    private static var _eventDispatcher:EventDispatcher = new EventDispatcher();

    private static var _getPetInfoFunc:Function;

    private static var _getPetInfoErrorFunc:Function;

    private static const PUT_TO_STORAGE_FLAG:int = 0;

    private static const PUT_IN_BAG_FLAG:int = 1;

    private static const UNFOLLOW_FLAG:int = 0;

    private static const FOLLOW_FLAG:int = 1;

    private static var _requestAddToBagPetId:uint;

    private static var _getPetStateCallBack:Function;

    private static const ATK:int = 0;

    private static const Def:int = 1;

    private static const Spatk:int = 2;

    private static const Spdef:int = 3;

    private static const Spd:int = 4;

    private static const Hp:int = 5;

    private static const QUALITY_LIMIT:Array = [[0, 119], [120, 239], [240, 359], [360, 479], [480, 599], [600, 719], [720, 720]];


    public function PetInfoManager() {
        super();
    }

    public static function setupPetInfoData(param1:IDataInput):void {
        handleFightPetInfo(param1);
        handleStoragePetInfo(param1);
        initPetHandle(param1);
        listenerDelete();
        PetPowerUpdate.setup();
    }

    private static function handleFightPetInfo(param1:IDataInput):void {
        var _loc2_:PetInfo = null;
        var _loc3_:int = int(param1.readUnsignedInt());
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc2_ = new PetInfo();
            PetInfo.readPetInfo(_loc2_, param1);
            addPetInfo(_loc2_);
            _loc4_++;
        }
    }

    private static function initPetHandle(param1:IDataInput):void {
        var _loc2_:PetInfo = null;
        var _loc4_:uint = 0;
        var _loc3_:int = int(param1.readUnsignedInt());
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc2_ = getPetInfoFromMap(_loc4_);
            PetInfo.readBaseSimpleInfo2(param1, _loc2_);
            _loc2_.flag = param1.readUnsignedInt();
            _loc2_.isInitialPet = true;
            addPetInfo(_loc2_);
            _loc5_++;
        }
        testPetBag();
    }

    private static function testPetBag():void {
        var _loc2_:PetInfo = null;
        var _loc1_:Array = _petInfoMap.getValues();
        for each(_loc2_ in _loc1_) {
            if (_loc2_.isInBag && !_loc2_.isInStorageBag && _loc2_.isSetBirth == false && _loc2_.isBirthIng == false) {
            }
        }
    }

    private static function handleStoragePetInfo(param1:IDataInput):void {
        var _loc2_:PetInfo = null;
        var _loc3_:int = int(param1.readUnsignedInt());
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc2_ = new PetInfo();
            PetInfo.readPetInfo(_loc2_, param1);
            addPetInfo1(_loc2_);
            _loc4_++;
        }
    }

    private static function listenerDelete():void {
        Connection.addCommandListener(CommandSet.CLI_NOTIFY_DEL_MONSTER_1259, toDelete);
    }

    private static function toDelete(param1:MessageEvent):void {
        new Parser_1259(param1.message.getRawData());
    }

    public static function getPetInfoFromMap(param1:uint):PetInfo {
        var _loc2_:PetInfo = null;
        if (_petInfoMap.containsKey(param1)) {
            _loc2_ = _petInfoMap.getValue(param1);
        } else {
            _loc2_ = new PetInfo();
            _loc2_.catchTime = param1;
        }
        return _loc2_;
    }

    public static function addPetInfo(param1:PetInfo):void {
        _petInfoMap.add(param1.catchTime, param1);
        if (param1.catchTime == _requestAddToBagPetId) {
            ServerMessager.addMessage(param1.name + "已经放入精灵背包");
        }
        dispatchEvent(PetInfoEvent.PET_ADD, param1);
    }

    public static function addPetInfo1(param1:PetInfo):void {
        _petStorageInfoMap.add(param1.catchTime, param1);
        if (param1.catchTime == _requestAddToBagPetId) {
            ServerMessager.addMessage(param1.name + "已经放入精灵背包仓库");
        }
        dispatchEvent(PetInfoEvent.PET_STORAGE_ADD, param1);
    }

    public static function removePetInfoFromBagById(param1:uint):void {
        var _loc2_:PetInfo = getPetInfoFromBag(param1);
        if (_loc2_ != null) {
            _loc2_.isInBag = false;
            dispatchEvent(PetInfoEvent.PET_REMOVE, _loc2_);
        }
    }

    public static function removePetDataFromBagById(param1:uint):void {
        var _loc2_:PetInfo = getPetInfoFromBagStorage(param1);
        if (_loc2_ != null) {
            _petInfoMap.remove(_loc2_.catchTime);
        }
    }

    public static function removePetDataFromStorageBagById(param1:uint):void {
        var _loc2_:PetInfo = getPetInfoFromBag(param1);
        if (_loc2_ != null) {
            _petStorageInfoMap.remove(_loc2_.catchTime);
        }
    }

    public static function removePetInfoFromBagStorageById(param1:uint):void {
        var _loc2_:PetInfo = getPetInfoFromBagStorage(param1);
        if (_loc2_ != null) {
            _loc2_.isInStorageBag = false;
            dispatchEvent(PetInfoEvent.PET_STORAGE_REMOVE, _loc2_);
        }
    }

    public static function deletePet(param1:uint):void {
        _petInfoMap.remove(param1);
        _petStorageInfoMap.remove(param1);
    }

    public static function getPetInfoFromBag(param1:uint):PetInfo {
        var _loc2_:PetInfo = null;
        if (_petInfoMap.containsKey(param1)) {
            _loc2_ = _petInfoMap.getValue(param1);
            if (_loc2_.isInBag) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function getPetInfoFromBagStorage(param1:uint):PetInfo {
        var _loc2_:PetInfo = null;
        if (_petStorageInfoMap.containsKey(param1)) {
            _loc2_ = _petStorageInfoMap.getValue(param1);
            if (_loc2_.isInStorageBag) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function getPetInfoFromAllBag(param1:uint):PetInfo {
        var _loc2_:PetInfo = getPetInfoFromBag(param1);
        if (_loc2_ == null) {
            _loc2_ = getPetInfoFromBagStorage(param1);
        }
        return _loc2_;
    }

    public static function getAllBagPetInfo():Vector.<PetInfo> {
        var _loc3_:PetInfo = null;
        var _loc1_:Vector.<PetInfo> = new Vector.<PetInfo>();
        var _loc2_:Array = _petInfoMap.getValues();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.isInBag && !_loc3_.isInStorageBag && _loc3_.isSetBirth == false && _loc3_.isBirthIng == false) {
                _loc1_.push(_loc3_);
            }
        }
        return _loc1_;
    }

    public static function getResPetInfo(param1:uint):PetInfo {
        var _loc3_:PetInfo = null;
        var _loc2_:Vector.<PetInfo> = getTotalBagPetInfo();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.resourceId == param1) {
                return _loc3_;
            }
        }
        return null;
    }

    public static function getTotalBagPetInfo():Vector.<PetInfo> {
        var _loc3_:PetInfo = null;
        var _loc4_:Array = null;
        var _loc5_:PetInfo = null;
        var _loc1_:Vector.<PetInfo> = new Vector.<PetInfo>();
        var _loc2_:Array = _petInfoMap.getValues();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.isInBag && !_loc3_.isInStorageBag && _loc3_.isSetBirth == false && _loc3_.isBirthIng == false) {
                _loc1_.push(_loc3_);
            }
        }
        _loc4_ = _petStorageInfoMap.getValues();
        for each(_loc5_ in _loc4_) {
            if (Boolean(_loc5_.isInStorageBag) && _loc5_.isSetBirth == false && _loc5_.isBirthIng == false) {
                _loc1_.push(_loc5_);
            }
        }
        return _loc1_;
    }

    public static function getAllBagPetStorageInfo():Vector.<PetInfo> {
        var _loc3_:PetInfo = null;
        var _loc1_:Vector.<PetInfo> = new Vector.<PetInfo>();
        var _loc2_:Array = _petStorageInfoMap.getValues();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.isInStorageBag && _loc3_.isSetBirth == false && _loc3_.isBirthIng == false) {
                _loc1_.push(_loc3_);
            }
        }
        return _loc1_;
    }

    public static function getRidingPetInfo():PetInfo {
        var _loc1_:Vector.<PetInfo> = getAllBagPetInfo();
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.length) {
            if (_loc1_[_loc2_].isPetRiding == true) {
                return _loc1_[_loc2_];
            }
            _loc2_++;
        }
        return null;
    }

    public static function getRandomFightPetInfo(param1:uint = 1):Vector.<PetInfo> {
        var _loc2_:Vector.<PetInfo> = getAllBagPetInfo();
        var _loc3_:uint = _loc2_.length;
        _loc3_ = param1 > _loc3_ ? _loc3_ : param1;
        return _loc2_.splice(0, _loc3_);
    }

    public static function isBagFull():Boolean {
        var _loc1_:Vector.<PetInfo> = getAllBagPetInfo();
        return _loc1_.length >= MAX_BAG_PET_COUNT;
    }

    public static function isBagStorageFull():Boolean {
        var _loc1_:Vector.<PetInfo> = getAllBagPetStorageInfo();
        return _loc1_.length >= VipManager.vipInfo.level + 1;
    }

    public static function getMaxPetLevel():uint {
        var _loc3_:PetInfo = null;
        var _loc1_:int = 0;
        var _loc2_:Vector.<PetInfo> = getAllBagPetInfo();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.level > _loc1_) {
                _loc1_ = int(_loc3_.level);
            }
        }
        return _loc1_;
    }

    public static function canCure():Boolean {
        var _loc2_:PetInfo = null;
        var _loc1_:Vector.<PetInfo> = getAllBagPetInfo();
        for each(_loc2_ in _loc1_) {
            if (_loc2_.hp != _loc2_.maxHp) {
                return true;
            }
        }
        return false;
    }

    public static function getSubPetInfo():PetInfo {
        var _loc2_:PetInfo = null;
        var _loc1_:Array = _petInfoMap.getValues();
        for each(_loc2_ in _loc1_) {
            if (_loc2_.isSubFighter == true) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function setSubPetInfo(param1:uint):void {
        if (param1 == 0) {
            return;
        }
        var _loc2_:PetInfo = getSubPetInfo();
        var _loc3_:PetInfo = getPetInfoFromBag(param1);
        if (_loc2_ != null) {
            _loc2_.isSubFighter = false;
        }
        if (_loc3_ != null) {
            _loc3_.isSubFighter = true;
            dispatchEvent(PetInfoEvent.PET_CHANGE_SUB, _loc3_);
        }
    }

    public static function getFirstPetInfo():PetInfo {
        var _loc2_:PetInfo = null;
        var _loc1_:Array = _petInfoMap.getValues();
        for each(_loc2_ in _loc1_) {
            if (_loc2_.isStarting == true) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function setFirst(param1:uint):void {
        if (param1 == 0) {
            return;
        }
        var _loc2_:PetInfo = getFirstPetInfo();
        var _loc3_:PetInfo = getPetInfoFromBag(param1);
        if (_loc2_ != null) {
            _loc2_.isStarting = false;
        }
        if (_loc3_ != null) {
            _loc3_.isStarting = true;
            dispatchEvent(PetInfoEvent.PET_CHANGE_STARTING, _loc3_);
        }
    }

    public static function updateStarPetInfo(param1:int, param2:Vector.<StarInfo>):void {
        var _loc4_:PetInfo = null;
        var _loc5_:Array = null;
        var _loc6_:PetInfo = null;
        var _loc3_:Array = _petInfoMap.getValues();
        for each(_loc4_ in _loc3_) {
            if (_loc4_.catchTime == param1) {
                if (param2.length > 0) {
                    _loc4_.petFightStarInfo.clear();
                    _loc4_.petFightStarInfo.addAll(param2);
                } else {
                    _loc4_.petFightStarInfo.clear();
                }
                return;
            }
        }
        _loc5_ = _petStorageInfoMap.getValues();
        for each(_loc6_ in _loc5_) {
            if (_loc4_.catchTime == param1) {
                if (param2.length > 0) {
                    _loc4_.petFightStarInfo.clear();
                    _loc4_.petFightStarInfo.addAll(param2);
                } else {
                    _loc4_.petFightStarInfo.clear();
                }
                return;
            }
        }
    }

    public static function getFollowingPetInfo():PetInfo {
        var _loc2_:PetInfo = null;
        var _loc1_:Array = _petInfoMap.getValues();
        for each(_loc2_ in _loc1_) {
            if (_loc2_.isFollowing == true) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function getPetRidingPetInfo():PetInfo {
        var _loc2_:PetInfo = null;
        var _loc1_:Array = _petInfoMap.getValues();
        for each(_loc2_ in _loc1_) {
            if (_loc2_.isPetRiding == true) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function getStoragePetInfos(param1:Function, param2:Boolean):void {
        var count1016:uint = 0;
        var onGetStorageList:Function = null;
        var onComplete:Function = param1;
        var serverUpdate:Boolean = param2;
        var requestStoragePetInfoList:Function = function ():void {
            Connection.addCommandListener(CommandSet.PET_GET_STORAGE_LIST_1016, onGetStorageList);
            Connection.send(CommandSet.PET_GET_STORAGE_LIST_1016, 1, 1000);
        };
        onGetStorageList = function (param1:MessageEvent):void {
            var _loc5_:uint = 0;
            var _loc6_:PetInfo = null;
            Connection.removeCommandListener(CommandSet.PET_GET_STORAGE_LIST_1016, onGetStorageList);
            var _loc2_:IDataInput = param1.message.getRawData();
            var _loc3_:int = int(_loc2_.readUnsignedInt());
            var _loc4_:int = 0;
            while (_loc4_ < _loc3_) {
                _loc5_ = uint(_loc2_.readUnsignedInt());
                _loc6_ = getPetInfoFromMap(_loc5_);
                PetInfo.readBaseSimpleInfo2(_loc2_, _loc6_);
                _loc6_.treasureTime = _loc2_.readUnsignedInt();
                _loc6_.evolveLevel = _loc2_.readUnsignedInt();
                _loc6_.isInBag = false;
                _loc6_.isInStorageBag = false;
                _loc6_.isInFreeStorage = false;
                _loc6_.isTraining = false;
                _petInfoMap.add(_loc6_.catchTime, _loc6_);
                _loc4_++;
            }
            if (count1016 == 0) {
                ++count1016;
                Connection.addCommandListener(CommandSet.PET_GET_STORAGE_LIST_1016, onGetStorageList);
                Connection.send(CommandSet.PET_GET_STORAGE_LIST_1016, 1001, 2000);
            } else {
                onComplete(getAllStoragePetInfo());
            }
        };
        var petInfoStorage:Vector.<PetInfo> = getAllStoragePetInfo();
        if (petInfoStorage.length == 0) {
            requestStoragePetInfoList();
        } else if (serverUpdate) {
            requestStoragePetInfoList();
        } else {
            onComplete(getAllStoragePetInfo());
        }
        count1016 = 0;
    }

    private static function getAllStoragePetInfo():Vector.<PetInfo> {
        var _loc3_:PetInfo = null;
        var _loc1_:Vector.<PetInfo> = new Vector.<PetInfo>();
        var _loc2_:Array = _petInfoMap.getValues();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.name == "布莱克") {
            }
            if (_loc3_.isInStorage == true && _loc3_.isInFreeStorage == false && _loc3_.isTraining == false && _loc3_.isDevilTraining == false && _loc3_.isSetBirth == false && _loc3_.isBirthIng == false) {
                _loc1_.push(_loc3_);
            }
        }
        return _loc1_;
    }

    public static function getPetInfoFromStorage(param1:uint):PetInfo {
        var _loc2_:PetInfo = null;
        if (_petInfoMap.containsKey(param1)) {
            _loc2_ = _petInfoMap.getValue(param1);
            if (_loc2_.isInBag == false && _loc2_.isSetBirth == false && _loc2_.isBirthIng == false && _loc2_.isInStorageBag == false) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function getInitialPetInfo():PetInfo {
        var _loc1_:PetInfo = null;
        var _loc2_:int = 0;
        var _loc4_:int = 0;
        var _loc3_:Vector.<PetInfo> = getInitialPetInfoVec();
        if (_loc3_.length == 0) {
            _loc1_ = null;
        } else {
            _loc2_ = int(_loc3_[0].catchTime);
            _loc4_ = 1;
            while (_loc4_ < _loc3_.length) {
                if (_loc2_ > _loc3_[_loc4_].catchTime) {
                    _loc2_ = int(_loc3_[_loc4_].catchTime);
                }
                _loc4_++;
            }
            _loc1_ = _petInfoMap.getValue(_loc2_);
        }
        return _loc1_;
    }

    public static function setInitialPetInfo(param1:PetInfo):void {
        var _loc2_:PetInfo = null;
        if (param1.resourceId <= 9) {
            _loc2_ = _petInfoMap.getValue(param1.catchTime);
            if (_loc2_ == null) {
                _loc2_ = new PetInfo();
                _petInfoMap.add(param1.catchTime, _loc2_);
            }
            _loc2_.level = param1.level;
            _loc2_.resourceId = param1.resourceId;
        }
    }

    public static function getInitialPetInfoVec():Vector.<PetInfo> {
        var _loc3_:PetInfo = null;
        var _loc1_:Vector.<PetInfo> = new Vector.<PetInfo>();
        var _loc2_:Array = _petInfoMap.getValues();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.isInitialPet) {
                _loc1_.push(_loc3_);
            }
        }
        return _loc1_;
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _eventDispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _eventDispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:String, param2:PetInfo, param3:* = null):void {
        if (_eventDispatcher.hasEventListener(param1)) {
            _eventDispatcher.dispatchEvent(new PetInfoEvent(param1, param2, param3));
        }
    }

    public static function hasEventListener(param1:String):Boolean {
        return _eventDispatcher.hasEventListener(param1);
    }

    public static function getPetInfo(param1:uint, param2:Function = null, param3:Function = null):void {
        _getPetInfoFunc = param2;
        _getPetInfoErrorFunc = param3;
        Connection.addCommandListener(CommandSet.GET_PETINFO_1074, onGetPetInfo);
        Connection.addErrorHandler(CommandSet.GET_PETINFO_1074, onGetPetInfoError);
        Connection.send(CommandSet.GET_PETINFO_1074, param1);
    }

    private static function onGetPetInfo(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.GET_PETINFO_1074, onGetPetInfo);
        Connection.removeErrorHandler(CommandSet.GET_PETINFO_1074, onGetPetInfoError);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:PetInfo = new PetInfo();
        _loc3_.catchTime = _loc2_.readUnsignedInt();
        _loc3_.sex = _loc2_.readByte();
        _loc3_.level = _loc2_.readUnsignedShort();
        _loc3_.hp = _loc2_.readUnsignedInt();
        _loc3_.maxHp = _loc2_.readUnsignedInt();
        _loc3_.atk = _loc2_.readUnsignedShort();
        _loc3_.specialAtk = _loc2_.readUnsignedShort();
        _loc3_.defence = _loc2_.readUnsignedShort();
        _loc3_.specialDefence = _loc2_.readUnsignedShort();
        _loc3_.speed = _loc2_.readUnsignedShort();
        _loc3_.expToLevelUp = _loc2_.readUnsignedInt();
        _loc3_.character = _loc2_.readUnsignedShort();
        _loc3_.resourceId = _loc2_.readUnsignedInt();
        _loc3_.potential = _loc2_.readUnsignedInt();
        if (_getPetInfoFunc != null) {
            _getPetInfoFunc(_loc3_);
            _getPetInfoFunc = null;
        }
    }

    private static function onGetPetInfoError(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.GET_PETINFO_1074, onGetPetInfo);
        Connection.removeErrorHandler(CommandSet.GET_PETINFO_1074, onGetPetInfoError);
        if (_getPetInfoErrorFunc != null) {
            _getPetInfoErrorFunc();
            _getPetInfoErrorFunc = null;
        }
    }

    public static function requestSetFirst(param1:uint):void {
        Connection.send(CommandSet.PET_SET_STARTING_1018, param1);
    }

    public static function requestSetSub(param1:uint):void {
        Connection.send(CommandSet.SET_SECOND_MON_1193, param1);
    }

    public static function requestAddToBagFromStorage(param1:uint, param2:int):void {
        var _loc4_:String = null;
        _requestAddToBagPetId = param1;
        checkIsBeFull();
        dispatchEvent(PetInfoEvent.SERVER_GET_PET, null, param2);
        if (isBagFull() == true || param2 == 301 || param2 == 302 || param2 == 303) {
            _loc4_ = PetConfig.getPetDefinition(param2).name;
            AlertManager.showGetPetInStorageAlert(param2, 1);
            return;
        }
        var _loc3_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc3_.writeUnsignedInt(param1);
        _loc3_.writeByte(PUT_IN_BAG_FLAG);
        Connection.send(CommandSet.PET_SET_STORAGE_STATUS_1020, _loc3_);
        AlertManager.showGetPetInBagAlert(param2, 1);
    }

    private static function checkIsBeFull():void {
        if (ActorManager.getActor().getInfo().petCount >= 900) {
            AlertManager.showAlert("你已经有900多只精灵了，仓库快要放不下了，放生掉一些精灵吧。");
        }
    }

    public static function requestAddToStorageFromBag(param1:uint):void {
        var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc2_.writeUnsignedInt(param1);
        _loc2_.writeByte(PUT_TO_STORAGE_FLAG);
        Connection.send(CommandSet.PET_SET_STORAGE_STATUS_1020, _loc2_);
    }

    public static function requestAddToStorageFromBagStorage(param1:uint):void {
        var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc2_.writeUnsignedInt(param1);
        _loc2_.writeByte(PUT_TO_STORAGE_FLAG);
        Connection.send(CommandSet.CLI_SET_MON_STATUS_VIP_1260, _loc2_);
    }

    public static function requestStartTrainingPet(param1:uint):void {
        Connection.send(CommandSet.PET_TRAINING_START_1039, param1);
    }

    public static function requestSetPetFollow(param1:uint, param2:int):void {
        var _loc3_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc3_.writeUnsignedInt(param1);
        _loc3_.writeByte(param2);
        Connection.send(CommandSet.PET_SET_FOLLOWING_1019, _loc3_);
    }

    public static function requestCurePet(param1:PetInfo):void {
        var _loc2_:LittleEndianByteArray = null;
        if (!RingSupport.getInstance().isRinger()) {
            _loc2_ = new LittleEndianByteArray();
            _loc2_.writeUnsignedInt(param1.catchTime);
            Connection.send(CommandSet.PET_CURE_1037, _loc2_);
        } else {
            AlertManager.showAlert("擂主不可加血!");
        }
    }

    public static function requestSetPetRide(param1:uint, param2:int):void {
        var _loc3_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc3_.writeUnsignedInt(param1);
        _loc3_.writeByte(param2);
        Connection.send(CommandSet.PET_SET_FOLLOWING_1019, _loc3_);
    }

    public static function getPetHaveState(param1:int, param2:Array, param3:Function = null):void {
        if (param3 != null) {
            _getPetStateCallBack = param3;
        }
        Connection.addCommandListener(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244, onGetPetHaveInfo);
        Connection.addErrorHandler(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244, onGetPetHaveInfoError);
        Connection.send(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244, param1, param2.length, param2);
    }

    private static function onGetPetHaveInfo(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244, onGetPetHaveInfo);
        Connection.removeErrorHandler(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244, onGetPetHaveInfoError);
        var _loc2_:Array = [];
        var _loc3_:IDataInput = param1.message.getRawDataCopy();
        _loc2_.push(_loc3_.readUnsignedInt());
        var _loc4_:int = int(_loc3_.readUnsignedInt());
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc2_.push(_loc3_.readUnsignedInt());
            _loc5_++;
        }
        if (_getPetStateCallBack != null) {
            _getPetStateCallBack(_loc2_);
        }
        _getPetStateCallBack = null;
    }

    private static function onGetPetHaveInfoError(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244, onGetPetHaveInfo);
        Connection.removeErrorHandler(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244, onGetPetHaveInfoError);
        _getPetStateCallBack = null;
    }

    public static function getPowerByPetInfo(param1:PetInfo):int {
        var _loc10_:int = 0;
        var _loc14_:int = 0;
        var _loc2_:int = 1;
        var _loc3_:int = param1.emblemId == 0 ? 0 : 200;
        var _loc4_:int = 0;
        if (param1.decorationId != 0) {
            _loc14_ = (param1.decorationId - 1) % 5 + 1;
            _loc4_ = int([120, 140, 160, 180, 200][_loc14_ - 1]);
        }
        var _loc5_:int = 0;
        var _loc6_:Array = [[30, 40, 50, 60, 70, 80], [60, 80, 100, 120, 140, 160], [120, 160, 200, 240, 280, 320], [240, 320, 400, 480, 560, 640]];
        var _loc7_:Array = param1.petFightStarInfo.type;
        var _loc8_:Array = param1.petFightStarInfo.level;
        var _loc9_:int = 0;
        while (_loc9_ < _loc7_.length) {
            _loc5_ += int(_loc6_[_loc7_[_loc9_] - 1][_loc8_[_loc9_] - 1]);
            _loc9_++;
        }
        var _loc11_:Number = createCurPropVal(param1.getPetDefinition().maxHp + int(PetEvolveConfig.getStarInfo(param1.evolveLevel) != null ? PetEvolveConfig.getStarInfo(param1.evolveLevel).Hp : 0), param1.learningInfo.pointHp, Hp, param1) * 17 + createCurPropVal(param1.getPetDefinition().atk + int(PetEvolveConfig.getStarInfo(param1.evolveLevel) != null ? PetEvolveConfig.getStarInfo(param1.evolveLevel).Atk : 0), param1.learningInfo.pointAtk, ATK, param1) * 16 + createCurPropVal(param1.getPetDefinition().specialAtk + int(PetEvolveConfig.getStarInfo(param1.evolveLevel) != null ? PetEvolveConfig.getStarInfo(param1.evolveLevel).SpAtk : 0), param1.learningInfo.pointSpecialAtk, Spatk, param1) * 16 + createCurPropVal(param1.getPetDefinition().defence + int(PetEvolveConfig.getStarInfo(param1.evolveLevel) != null ? PetEvolveConfig.getStarInfo(param1.evolveLevel).Def : 0), param1.learningInfo.pointDefence, Def, param1) * 14 + createCurPropVal(param1.getPetDefinition().specialDefence + int(PetEvolveConfig.getStarInfo(param1.evolveLevel) != null ? PetEvolveConfig.getStarInfo(param1.evolveLevel).SpDef : 0), param1.learningInfo.pointSpecialDefence, Spdef, param1) * 14 + createCurPropVal(param1.getPetDefinition().speed + int(PetEvolveConfig.getStarInfo(param1.evolveLevel) != null ? PetEvolveConfig.getStarInfo(param1.evolveLevel).Spd : 0), param1.learningInfo.pointSpeed, Spd, param1) * 30;
        var _loc12_:PetDefinition;
        var _loc13_:int = (_loc12_ = PetUtil.getMaxStatusPet(param1.bunchId)).atk + _loc12_.specialAtk + _loc12_.defence + _loc12_.specialDefence + _loc12_.speed + _loc12_.maxHp - 650;
        return int(_loc11_ * _loc13_ / (780 - 650) * _loc2_ + _loc3_ + _loc4_ + _loc5_ + 0.5);
    }

    public static function getAllPetBagPower():int {
        var _loc2_:PetInfo = null;
        var _loc1_:int = 0;
        for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
            _loc1_ += getPowerByPetInfo(_loc2_);
        }
        return _loc1_;
    }

    private static function createCurPropVal(param1:int, param2:int, param3:int, param4:PetInfo):Number {
        var _loc5_:Number = NaN;
        var _loc6_:Vector.<int> = Vector.<int>([param4.potentialAtk, param4.potentialDef, param4.potentialSpAtk, param4.potentialSpDef, param4.potentialSpeed, param4.potentialHp]);
        if (param3 != 5) {
            _loc5_ = ((param1 * 2 + _loc6_[param3]) * (param4.level / 100) + param4.level + 10 + param2 / 4) * param4.characterArr[param3];
        } else {
            _loc5_ = (param1 * 2 + _loc6_[param3]) * (param4.level / 100) + param4.level + 10 + param2 / 4;
        }
        return _loc5_;
    }

    public static function getPotentialDes(param1:uint):String {
        if (param1 >= 0 && param1 <= 11) {
            return "一般 ";
        }
        if (param1 >= 12 && param1 <= 21) {
            return "良 ";
        }
        if (param1 >= 22 && param1 <= 23) {
            return "优-";
        }
        if (param1 >= 24 && param1 <= 27) {
            return "优+";
        }
        if (param1 >= 28 && param1 <= 30) {
            return "稀有";
        }
        return "极";
    }

    public static function getQualityLevel(param1:int):int {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        while (_loc3_ < QUALITY_LIMIT.length) {
            if (param1 >= QUALITY_LIMIT[_loc3_][0] && param1 <= QUALITY_LIMIT[_loc3_][1]) {
                _loc2_ = _loc3_;
                break;
            }
            _loc3_++;
        }
        if (param1 > QUALITY_LIMIT[QUALITY_LIMIT.length - 1][1]) {
            _loc2_ = int(QUALITY_LIMIT.length - 1);
        }
        return _loc2_;
    }

    public static function getProcessNeedPoint(param1:int):int {
        var _loc2_:int = 0;
        var _loc3_:int = getQualityLevel(param1);
        if (_loc3_ < QUALITY_LIMIT.length - 1) {
            if (param1 < QUALITY_LIMIT[_loc3_][1]) {
                _loc2_ = QUALITY_LIMIT[_loc3_][1] - param1;
            } else {
                _loc2_ = QUALITY_LIMIT[_loc3_ + 1][0] - param1;
            }
        } else {
            _loc2_ = QUALITY_LIMIT[QUALITY_LIMIT.length - 1][1] - param1;
            if (_loc2_ < 0) {
                _loc2_ = 0;
            }
        }
        return _loc2_;
    }

    public static function oldPotentialHandle():Boolean {
        var _loc1_:Boolean = true;
        AlertManager.showAlert("活动功能已下线!");
        return _loc1_;
    }
}
}
