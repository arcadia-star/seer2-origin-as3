package com.taomee.seer2.app.pet.data {
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.PetEvolveConfig;
import com.taomee.seer2.app.config.pet.PetDefinition;
import com.taomee.seer2.app.pet.constant.PetCharactarNameMap;
import com.taomee.seer2.app.pet.constant.PetFeatureNameMap;
import com.taomee.seer2.app.pet.events.PetInfoEvent;

import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;

public class PetInfo {


    private var _catchTime:uint;

    private var _sex:uint;

    private var _level:uint;

    private var _hp:uint;

    private var _maxHp:uint;

    private var _atk:uint;

    private var _specialAtk:uint;

    private var _defence:uint;

    private var _specialDefence:uint;

    private var _speed:uint;

    private var _expToLevelUp:uint;

    private var _character:uint;

    private var _resourceId:uint;

    private var _petDefinition:PetDefinition;

    public var freeTime:uint;

    public var treasureTime:uint;

    private var _physicalHeight:uint;

    private var _physicalWeight:uint;

    private var _potential:int = -1;

    private var _emblemId:int = -1;

    private var _decorationId:int = -1;

    private var _battleLevel:uint;

    private var _flag:int = -1;

    private var _isInBag:Boolean;

    private var _isInStorageBag:Boolean;

    private var _isStarting:Boolean;

    private var _isFollowing:Boolean;

    private var _isInFreeStorage:Boolean;

    private var _isTraining:Boolean;

    private var _isAggraisal:Boolean;

    private var _isDevilTraining:Boolean;

    private var _isSubFighter:Boolean;

    private var _isInitialPet:Boolean;

    private var _isSetBirth:Boolean;

    private var _isBirthIng:Boolean;

    private var _isTwoPet:Boolean;

    private var _isTestCheck:Boolean;

    private var _learningInfo:PetLearningInfo;

    private var _skillInfo:PetSkillInfo;

    private var _trainingCount:uint;

    private var _twoExp:uint;

    private var _threeExp:uint;

    private var _twoStudy:uint;

    private var _petFightStarInfo:PetFightStarInfo;

    private var _potentialAtk:uint;

    private var _potentialDef:uint;

    private var _potentialSpAtk:uint;

    private var _potentialSpDef:uint;

    private var _potentialSpeed:uint;

    private var _potentialHp:uint;

    private var _totalPotential:uint;

    private var _hasStar:Boolean;

    public var evolveLevel:uint;

    public var isPetRiding:Boolean;

    public var petRideChipId:int = -1;

    public var chipPutOnTime:uint = 0;

    public var itemList:Vector.<PetItemInfo>;

    public function PetInfo() {
        this.itemList = Vector.<PetItemInfo>([]);
        super();
    }

    public static function updateBaseInfo(param1:PetInfo, param2:PetInfo):void {
        param1.sex = param2.sex;
        param1.level = param2.level;
        param1.hp = param2.hp;
        param1.maxHp = param2.maxHp;
        param1.atk = param2.atk;
        param1.specialAtk = param2.specialAtk;
        param1.defence = param2.defence;
        param1.specialDefence = param2.specialDefence;
        param1.speed = param2.speed;
        param1.expToLevelUp = param2.expToLevelUp;
        param1.character = param2.character;
        param1.resourceId = param2.resourceId;
    }

    public static function updatePetBaseInfo(param1:PetInfo, param2:PetInfo):void {
        param1.sex = param2.sex;
        param1.level = param2.level;
        param1.hp = param2.hp;
        param1.maxHp = param2.maxHp;
        param1.atk = param2.atk;
        param1.specialAtk = param2.specialAtk;
        param1.defence = param2.defence;
        param1.specialDefence = param2.specialDefence;
        param1.speed = param2.speed;
        param1.expToLevelUp = param2.expToLevelUp;
        param1.character = param2.character;
        param1.resourceId = param2.resourceId;
        param1.potential = param2.potential;
    }

    public static function updateShopItemPetInfo(param1:PetInfo, param2:IDataInput):void {
        param1.twoExp = param2.readUnsignedInt();
        param1.threeExp = param2.readUnsignedInt();
        param1.twoStudy = param2.readUnsignedInt();
    }

    public static function readFreeTime(param1:PetInfo, param2:IDataInput):void {
        param1.freeTime = param2.readUnsignedInt();
    }

    public static function readBaseSimpleInfo(param1:PetInfo, param2:IDataInput):void {
        param1.catchTime = param2.readUnsignedInt();
        readBaseSimpleInfo2(param2, param1);
    }

    public static function readBaseSimpleInfo2(param1:IDataInput, param2:PetInfo):void {
        param2.resourceId = param1.readUnsignedInt();
        param2.level = param1.readUnsignedShort();
    }

    public static function readPetInfo(param1:PetInfo, param2:IDataInput):void {
        if (param2) {
            readBaseInfo(param1, param2);
            param1.flag = param2.readUnsignedInt();
            param1.learningInfo.pointUnused = param2.readUnsignedShort();
            param1.learningInfo.pointHp = param2.readUnsignedShort();
            param1.learningInfo.pointAtk = param2.readUnsignedShort();
            param1.learningInfo.pointSpecialAtk = param2.readUnsignedShort();
            param1.learningInfo.pointDefence = param2.readUnsignedShort();
            param1.learningInfo.pointSpecialDefence = param2.readUnsignedShort();
            param1.learningInfo.pointSpeed = param2.readUnsignedShort();
            readSkillInfo(param1, param2);
            readCandidateSkillInfo(param1, param2);
            param1.potential = param2.readUnsignedInt();
            param1.battleLevel = param2.readUnsignedInt();
            param1.potentialAtk = param2.readUnsignedInt();
            param1.potentialDef = param2.readUnsignedInt();
            param1.potentialSpAtk = param2.readUnsignedInt();
            param1.potentialSpDef = param2.readUnsignedInt();
            param1.potentialSpeed = param2.readUnsignedInt();
            param1.potentialHp = param2.readUnsignedInt();
            readStarInfo(param1, param2);
            param1.physicalHeight = param2.readUnsignedShort();
            param1.physicalWeight = param2.readUnsignedShort();
            param1.emblemId = param2.readUnsignedInt();
            param1.trainingCount = param2.readUnsignedShort();
            param1.decorationId = param2.readUnsignedInt();
            param1.petRideChipId = param2.readUnsignedInt();
            param1.chipPutOnTime = param2.readUnsignedInt();
            param1.evolveLevel = param2.readUnsignedInt();
        }
    }

    public static function readSkillInfo(param1:PetInfo, param2:IDataInput):void {
        var _loc5_:uint = 0;
        var _loc3_:Vector.<SkillInfo> = new Vector.<SkillInfo>();
        var _loc4_:int = int(param2.readUnsignedInt());
        if (param1.resourceId == 703) {
        }
        var _loc6_:int = 0;
        while (_loc6_ < _loc4_) {
            _loc5_ = uint(param2.readUnsignedInt());
            _loc3_.push(new SkillInfo(_loc5_));
            if (param1.resourceId == 703) {
            }
            _loc6_++;
        }
        param1.skillInfo.skillInfoVec = _loc3_;
    }

    public static function readStarInfo(param1:PetInfo, param2:IDataInput):void {
        var _loc4_:uint = 0;
        var _loc5_:uint = 0;
        if (!param1._petFightStarInfo) {
            param1._petFightStarInfo = new PetFightStarInfo();
        }
        param1._petFightStarInfo.clear();
        var _loc3_:uint = uint(param2.readUnsignedInt());
        var _loc6_:int = 0;
        while (_loc6_ < _loc3_) {
            _loc4_ = uint(param2.readUnsignedInt());
            _loc5_ = uint(param2.readUnsignedInt());
            param1._petFightStarInfo.add(_loc5_, _loc4_);
            _loc6_++;
        }
    }

    public static function readCandidateSkillInfo(param1:PetInfo, param2:IDataInput):void {
        var _loc5_:uint = 0;
        var _loc3_:Vector.<SkillInfo> = new Vector.<SkillInfo>();
        var _loc4_:int = int(param2.readUnsignedInt());
        if (param1.resourceId == 703) {
        }
        var _loc6_:int = 0;
        while (_loc6_ < _loc4_) {
            _loc5_ = uint(param2.readUnsignedInt());
            _loc3_.push(new SkillInfo(_loc5_));
            if (param1.resourceId == 703) {
            }
            _loc6_++;
        }
        param1.skillInfo.candidateSkillInfoVec = _loc3_;
    }

    public static function readGainedSkillInfo(param1:PetInfo, param2:IDataInput):void {
        var _loc6_:uint = 0;
        var _loc7_:SkillInfo = null;
        var _loc3_:Vector.<SkillInfo> = new Vector.<SkillInfo>();
        var _loc4_:uint = uint(param2.readUnsignedInt());
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = uint(param2.readUnsignedInt());
            _loc7_ = new SkillInfo(_loc6_);
            _loc3_.push(_loc7_);
            _loc5_++;
        }
        param1.skillInfo.gainedSkillInfoVec = _loc3_;
    }

    public static function readDetailInfo(param1:PetInfo, param2:IDataInput):void {
        param1.flag = param2.readUnsignedInt();
        param1.physicalHeight = param2.readUnsignedShort();
        param1.physicalWeight = param2.readUnsignedShort();
        param1.potential = param2.readUnsignedInt();
        param1.emblemId = param2.readUnsignedInt();
        param1.decorationId = param2.readUnsignedInt();
        param1.evolveLevel = param2.readUnsignedInt();
    }

    public static function readBaseInfo(param1:PetInfo, param2:IDataInput):void {
        param1.catchTime = param2.readUnsignedInt();
        param1.sex = param2.readUnsignedByte();
        param1.level = param2.readUnsignedShort();
        param1.hp = param2.readUnsignedInt();
        param1.maxHp = param2.readUnsignedInt();
        param1.atk = param2.readUnsignedShort();
        param1.specialAtk = param2.readUnsignedShort();
        param1.defence = param2.readUnsignedShort();
        param1.specialDefence = param2.readUnsignedShort();
        param1.speed = param2.readUnsignedShort();
        param1.expToLevelUp = param2.readUnsignedInt();
        param1.character = param2.readUnsignedShort();
        param1.resourceId = param2.readUnsignedInt();
    }

    public static function readBaseBaseInfo(param1:PetInfo, param2:IDataInput):void {
        param1.sex = param2.readUnsignedByte();
        param1.level = param2.readUnsignedShort();
        param1.hp = param2.readUnsignedInt();
        param1.maxHp = param2.readUnsignedInt();
        param1.atk = param2.readUnsignedShort();
        param1.specialAtk = param2.readUnsignedShort();
        param1.defence = param2.readUnsignedShort();
        param1.specialDefence = param2.readUnsignedShort();
        param1.speed = param2.readUnsignedShort();
        param1.expToLevelUp = param2.readUnsignedInt();
        param1.character = param2.readUnsignedShort();
        param1.resourceId = param2.readUnsignedInt();
    }

    public static function readPetInfo_1116(param1:PetInfo, param2:IDataInput):PetInfo {
        if (param2 != null) {
            param1.catchTime = param2.readUnsignedInt();
            param1.sex = param2.readUnsignedByte();
            param1.level = param2.readUnsignedShort();
            param1.hp = param2.readUnsignedInt();
            param1.maxHp = param2.readUnsignedInt();
            param1.atk = param2.readUnsignedShort();
            param1.specialAtk = param2.readUnsignedShort();
            param1.defence = param2.readUnsignedShort();
            param1.specialDefence = param2.readUnsignedShort();
            param1.speed = param2.readUnsignedShort();
            param1.expToLevelUp = param2.readUnsignedInt();
            param1.character = param2.readUnsignedShort();
            param1.potential = param2.readUnsignedInt();
            param1.resourceId = param2.readUnsignedInt();
            param1.flag = param2.readUnsignedInt();
        }
        return param1;
    }

    public function get catchTime():uint {
        return this._catchTime;
    }

    public function get hasStar():Boolean {
        return this._hasStar;
    }

    public function set hasStar(param1:Boolean):void {
        this._hasStar = param1;
    }

    private function updateFlag():void {
        var _loc1_:int = 0;
        _loc1_ += this._isInBag ? 1 : 0;
        _loc1_ += this._isStarting ? 2 : 0;
        _loc1_ += this._isFollowing ? 4 : 0;
        _loc1_ += this._isInFreeStorage ? 8 : 0;
        _loc1_ += this._isTraining ? 16 : 0;
        _loc1_ += this._isAggraisal ? 32 : 0;
        _loc1_ += this._isDevilTraining ? 64 : 0;
        _loc1_ += this._isSubFighter ? 128 : 0;
        _loc1_ += this._isSetBirth ? 256 : 0;
        _loc1_ += this._isBirthIng ? 1024 : 0;
        _loc1_ += this._isTwoPet ? 2048 : 0;
        _loc1_ += this._isTestCheck ? 4096 : 0;
        _loc1_ += this.isPetRiding ? 8162 : 0;
        _loc1_ += this._isInStorageBag ? 16384 : 0;
        this._flag = _loc1_;
        PetInfoManager.dispatchEvent(PetInfoEvent.PET_FLAG_CHANGE, this);
    }

    public function get flag():int {
        return this._flag;
    }

    public function set flag(param1:int):void {
        this._flag = param1;
        this._isInBag = (param1 & 1) == 1;
        this._isStarting = (param1 & 2) == 2;
        this._isFollowing = (param1 & 4) == 4;
        this._isInFreeStorage = (param1 & 8) == 8;
        this._isTraining = (param1 & 16) == 16;
        this._isAggraisal = (param1 & 32) == 32;
        this._isDevilTraining = (param1 & 64) == 64;
        this._isSubFighter = (param1 & 128) == 128;
        this._isSetBirth = (param1 & 256) == 256;
        this._isBirthIng = (param1 & 1024) == 1024;
        this._isTwoPet = (param1 & 2048) == 2048;
        this.isPetRiding = (param1 & 8192) == 8192;
        this._isInStorageBag = BitUtil.getBit(param1, 14);
        PetInfoManager.dispatchEvent(PetInfoEvent.PET_FLAG_CHANGE, this);
    }

    public function get petFightStarInfo():PetFightStarInfo {
        return this._petFightStarInfo;
    }

    public function set petFightStarInfo(param1:PetFightStarInfo):void {
        this._petFightStarInfo = param1;
    }

    public function get isDevilTraining():Boolean {
        return this._isDevilTraining;
    }

    public function set isDevilTraining(param1:Boolean):void {
        this._isDevilTraining = param1;
        this.updateFlag();
    }

    public function set twoExp(param1:uint):void {
        this._twoExp = param1;
    }

    public function set threeExp(param1:uint):void {
        this._threeExp = param1;
    }

    public function set twoStudy(param1:uint):void {
        this._twoStudy = param1;
    }

    public function get isInStorage():Boolean {
        return !this._isInBag && !this._isTraining && !this._isDevilTraining && !this._isInFreeStorage && !this._isInStorageBag;
    }

    public function get isInBag():Boolean {
        return this._isInBag;
    }

    public function get isSubFighter():Boolean {
        return this._isSubFighter;
    }

    public function get isStarting():Boolean {
        return this._isStarting;
    }

    public function get isFollowing():Boolean {
        return this._isFollowing;
    }

    public function get isInFreeStorage():Boolean {
        return this._isInFreeStorage;
    }

    public function get isTraining():Boolean {
        return this._isTraining;
    }

    public function get isAggraisal():Boolean {
        return this._isAggraisal;
    }

    public function get isTwoPet():Boolean {
        return this._isTwoPet;
    }

    public function get isSetBirth():Boolean {
        return this._isSetBirth;
    }

    public function get isBirthIng():Boolean {
        return this._isBirthIng;
    }

    public function get twoExp():uint {
        return this._twoExp;
    }

    public function get threeExp():uint {
        return this._threeExp;
    }

    public function get twoStudy():uint {
        return this._twoStudy;
    }

    public function set isInBag(param1:Boolean):void {
        this._isInBag = param1;
        this.updateFlag();
    }

    public function set isInStorageBag(param1:Boolean):void {
        this._isInStorageBag = param1;
        this.updateFlag();
    }

    public function get isInStorageBag():Boolean {
        return this._isInStorageBag;
    }

    public function set isStarting(param1:Boolean):void {
        this._isStarting = param1;
        this.updateFlag();
    }

    public function set isSubFighter(param1:Boolean):void {
        this._isSubFighter = param1;
        this.updateFlag();
    }

    public function set isFollowing(param1:Boolean):void {
        this._isFollowing = param1;
        this.updateFlag();
    }

    public function set isInFreeStorage(param1:Boolean):void {
        this._isInFreeStorage = param1;
        this.updateFlag();
    }

    public function set isTraining(param1:Boolean):void {
        this._isTraining = param1;
        this.updateFlag();
    }

    public function set isAggraisal(param1:Boolean):void {
        this._isAggraisal = param1;
        this.updateFlag();
    }

    public function set isTwoPet(param1:Boolean):void {
        this._isTwoPet = param1;
        this.updateFlag();
    }

    public function set isSetBirth(param1:Boolean):void {
        this._isSetBirth = param1;
        this.updateFlag();
    }

    public function set isBirthIng(param1:Boolean):void {
        this._isBirthIng = param1;
        this.updateFlag();
    }

    public function get isInitialPet():Boolean {
        return this._isInitialPet;
    }

    public function set isInitialPet(param1:Boolean):void {
        this._isInitialPet = param1;
    }

    public function get sex():uint {
        return this._sex;
    }

    public function set sex(param1:uint):void {
        this._sex = param1;
    }

    public function get level():uint {
        return this._level;
    }

    public function set level(param1:uint):void {
        this._level = param1;
    }

    public function get hp():uint {
        return this._hp;
    }

    public function set hp(param1:uint):void {
        this._hp = param1;
    }

    public function get maxHp():uint {
        return this._maxHp;
    }

    public function set maxHp(param1:uint):void {
        this._maxHp = param1;
    }

    public function get atk():uint {
        return this._atk;
    }

    public function set atk(param1:uint):void {
        this._atk = param1;
    }

    public function get specialAtk():uint {
        return this._specialAtk;
    }

    public function set specialAtk(param1:uint):void {
        this._specialAtk = param1;
    }

    public function get defence():uint {
        return this._defence;
    }

    public function set defence(param1:uint):void {
        this._defence = param1;
    }

    public function get specialDefence():uint {
        return this._specialDefence;
    }

    public function set specialDefence(param1:uint):void {
        this._specialDefence = param1;
    }

    public function get speed():uint {
        return this._speed;
    }

    public function set speed(param1:uint):void {
        this._speed = param1;
    }

    public function get expToLevelUp():uint {
        return this._expToLevelUp;
    }

    public function set expToLevelUp(param1:uint):void {
        this._expToLevelUp = param1;
    }

    public function get character():uint {
        return this._character;
    }

    public function set character(param1:uint):void {
        this._character = param1;
    }

    public function get resourceId():uint {
        return this._resourceId;
    }

    public function set resourceId(param1:uint):void {
        this._resourceId = param1;
    }

    public function set potentialAtk(param1:uint):void {
        this._potentialAtk = param1;
    }

    public function get potentialAtk():uint {
        return this._potentialAtk;
    }

    public function set potentialDef(param1:uint):void {
        this._potentialDef = param1;
    }

    public function get potentialDef():uint {
        return this._potentialDef;
    }

    public function set potentialSpAtk(param1:uint):void {
        this._potentialSpAtk = param1;
    }

    public function get potentialSpAtk():uint {
        return this._potentialSpAtk;
    }

    public function set potentialSpDef(param1:uint):void {
        this._potentialSpDef = param1;
    }

    public function get potentialSpDef():uint {
        return this._potentialSpDef;
    }

    public function set potentialSpeed(param1:uint):void {
        this._potentialSpeed = param1;
    }

    public function get potentialSpeed():uint {
        return this._potentialSpeed;
    }

    public function set potentialHp(param1:uint):void {
        this._potentialHp = param1;
    }

    public function get potentialHp():uint {
        return this._potentialHp;
    }

    public function get totalPotential():uint {
        return this._potentialAtk + this._potentialDef + this._potentialSpAtk + this._potentialSpDef + this._potentialSpeed + this._potentialHp;
    }

    public function get description():String {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.description;
        }
        return "未设置";
    }

    public function get name():String {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return PetEvolveConfig.getPrefix(this.evolveLevel) + _loc1_.name;
        }
        return "未设置";
    }

    public function set name(param1:String):void {
        var _loc2_:PetDefinition = this.getPetDefinition();
        _loc2_.name = param1;
    }

    public function get isCatchable():Boolean {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.catchRatio > 0;
        }
        return false;
    }

    public function get bunchId():uint {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.bunchId;
        }
        return 0;
    }

    public function getSloganVec():Vector.<String> {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.sloganVec;
        }
        return new Vector.<String>();
    }

    public function get foundPlace():String {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.foundPlace;
        }
        return "未设置";
    }

    public function get type():int {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.type;
        }
        return 0;
    }

    public function getPetDefinition():PetDefinition {
        this._petDefinition = PetConfig.getPetDefinition(this.resourceId);
        return this._petDefinition;
    }

    public function get feature():String {
        return PetFeatureNameMap.getFeatureName(this.featureId);
    }

    public function get characterName():String {
        return PetCharactarNameMap.getCharactarName(this.character);
    }

    public function get characterArr():Array {
        return PetCharactarNameMap.getCharactarArr(this.character);
    }

    public function get featureId():int {
        return PetConfig.getPetDefinition(this.resourceId).featureId;
    }

    public function get featureDescription():String {
        return PetConfig.getPetDefinition(this.resourceId).featureDescription;
    }

    public function get physicalHeight():uint {
        return this._physicalHeight;
    }

    public function set petDefinition(param1:PetDefinition):void {
        this._petDefinition = param1;
    }

    public function set physicalHeight(param1:uint):void {
        this._physicalHeight = param1;
    }

    public function get physicalWeight():uint {
        return this._physicalWeight;
    }

    public function set physicalWeight(param1:uint):void {
        this._physicalWeight = param1;
    }

    public function get potential():int {
        return this._potential;
    }

    public function set potential(param1:int):void {
        this._potential = param1;
    }

    public function get emblemId():int {
        return this._emblemId;
    }

    public function set emblemId(param1:int):void {
        this._emblemId = param1;
    }

    public function get decorationId():int {
        return this._decorationId;
    }

    public function set decorationId(param1:int):void {
        this._decorationId = param1;
    }

    public function get battleLevel():uint {
        return this._battleLevel;
    }

    public function set battleLevel(param1:uint):void {
        this._battleLevel = param1;
    }

    public function set trainingCount(param1:uint):void {
        this._trainingCount = param1;
    }

    public function get trainingCount():uint {
        return this._trainingCount;
    }

    public function get skillInfo():PetSkillInfo {
        if (this._skillInfo == null) {
            this._skillInfo = new PetSkillInfo();
        }
        return this._skillInfo;
    }

    public function get learningInfo():PetLearningInfo {
        if (this._learningInfo == null) {
            this._learningInfo = new PetLearningInfo();
        }
        return this._learningInfo;
    }

    public function set testCheck(param1:Boolean):void {
        this._isTestCheck = param1;
    }

    public function get testCheck():Boolean {
        return this._isTestCheck;
    }

    public function replacePetSkill(param1:Vector.<SkillInfo>, param2:Vector.<SkillInfo>):void {
        var _loc3_:PetSkillInfo = new PetSkillInfo();
        _loc3_.skillInfoVec = param1;
        _loc3_.candidateSkillInfoVec = param2;
        _loc3_.gainedSkillInfoVec = Vector.<SkillInfo>([]);
        this.skillInfo = _loc3_;
    }

    public function set learningInfo(param1:PetLearningInfo):void {
        this._learningInfo = param1;
    }

    public function set skillInfo(param1:PetSkillInfo):void {
        this._skillInfo = param1;
    }

    public function set catchTime(param1:uint):void {
        this._catchTime = param1;
    }
}
}
