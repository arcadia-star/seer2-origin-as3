package com.taomee.seer2.app.arena.data {
import com.taomee.seer2.app.arena.util.ArenaUtil;
import com.taomee.seer2.app.arena.util.SkillCategoryValue;
import com.taomee.seer2.app.arena.util.SkillFieldTable;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.PetEvolveConfig;
import com.taomee.seer2.app.config.pet.PetDefinition;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.data.SkillInfo;

import flash.utils.IDataInput;

public class FighterInfo {


    public var isChangeStatus:int = 0;

    public var isChangePet:Boolean;

    public var isChange:int;

    private var _userId:uint;

    private var _catchTime:uint;

    private var _resourceId:uint;

    private var _position:uint;

    private var _level:uint;

    private var _hp:uint;

    private var _maxHp:uint;

    private var _fightAnger:uint = 100;

    private var _maxAnger:uint = 100;

    private var _skillInfoVec:Vector.<SkillInfo>;

    private var _evolveLevel:uint;

    private var _isFightAngle:Boolean;

    private var _petDefinition:PetDefinition;

    private var _fightBuffInfoVec:Vector.<FighterBuffInfo>;

    public function FighterInfo(param1:uint, param2:IDataInput) {
        this._fightBuffInfoVec = new Vector.<FighterBuffInfo>();
        super();
        this._userId = param1;
        this._catchTime = param2.readUnsignedInt();
        this._fightAnger = param2.readUnsignedInt();
        this._resourceId = param2.readUnsignedInt();
        this._position = param2.readUnsignedByte();
        this._level = param2.readUnsignedShort();
        this._hp = param2.readUnsignedInt();
        this._maxHp = param2.readUnsignedInt();
        this._skillInfoVec = new Vector.<SkillInfo>();
        var _loc3_:uint = uint(param2.readUnsignedInt());
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._skillInfoVec.push(new SkillInfo(param2.readUnsignedInt()));
            _loc4_++;
        }
        this._evolveLevel = param2.readUnsignedInt();
    }

    public function get evolveLevel():uint {
        return this._evolveLevel;
    }

    public function printInfomation(param1:String = ""):void {
        var _loc2_:SkillInfo = null;
        for each(_loc2_ in this._skillInfoVec) {
        }
    }

    public function checkItemAnger(param1:ItemUseResultInfo):Boolean {
        return this._fightAnger > param1.anger;
    }

    public function checkSkillAnger(param1:SkillInfo):Boolean {
        var _loc2_:PetInfo = PetInfoManager.getPetInfoFromBag(this._catchTime);
        if (_loc2_ != null && _loc2_.emblemId == 300035) {
            if (ArenaUtil.UNCHECK_ANGER_SKILLS.indexOf(param1.id) != -1) {
                return true;
            }
        }
        return this._fightAnger >= param1.anger;
    }

    public function changeHp(param1:int):void {
        var _loc2_:int = int(this._hp);
        var _loc3_:int = _loc2_ + param1;
        if (_loc3_ > this._maxHp) {
            this._hp = this._maxHp;
            return;
        }
        if (_loc3_ < 0) {
            this._hp = 0;
            return;
        }
        this._hp = _loc3_;
    }

    private function getPetDefinition():PetDefinition {
        if (this._petDefinition == null) {
            this._petDefinition = PetConfig.getPetDefinition(this._resourceId);
        }
        return this._petDefinition;
    }

    public function hasSuperSkill():Boolean {
        var _loc1_:Boolean = false;
        var _loc2_:Vector.<SkillInfo> = this._skillInfoVec;
        var _loc3_:uint = _loc2_.length;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            if (_loc2_[_loc4_].id != 0) {
                if (_loc2_[_loc4_].categoryId == SkillCategoryValue.POW_VALUE) {
                    _loc1_ = true;
                    break;
                }
            }
            _loc4_++;
        }
        return _loc1_;
    }

    public function getSuperSkill():SkillInfo {
        var _loc1_:Vector.<SkillInfo> = this._skillInfoVec;
        var _loc2_:uint = _loc1_.length;
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            if (_loc1_[_loc3_].id != 0) {
                if (_loc1_[_loc3_].categoryId == SkillCategoryValue.POW_VALUE) {
                    return _loc1_[_loc3_];
                }
            }
            _loc3_++;
        }
        return null;
    }

    public function getSkillInfo(param1:int):SkillInfo {
        var _loc2_:SkillInfo = null;
        for each(var _loc5_ in this._skillInfoVec) {
            _loc2_ = _loc5_;
            _loc5_;
            if (_loc2_.id == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function setSkillList(param1:Vector.<SkillInfo>):void {
        this._skillInfoVec = param1;
    }

    public function get name():String {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return PetEvolveConfig.getPrefix(this.evolveLevel) + _loc1_.name;
        }
        return "未设置";
    }

    public function get type():String {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return SkillFieldTable.getTypeName(_loc1_.type);
        }
        return "未设置";
    }

    public function get typeId():int {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.type;
        }
        return 0;
    }

    public function get bunchId():uint {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.bunchId;
        }
        return 0;
    }

    public function get isCatchable():Boolean {
        var _loc1_:PetDefinition = this.getPetDefinition();
        if (_loc1_) {
            return _loc1_.catchRatio > 0;
        }
        return false;
    }

    public function set fightAnger(param1:int):void {
        param1 = param1 < 0 ? 0 : param1;
        param1 = param1 > 100 ? 100 : param1;
        this._fightAnger = param1;
    }

    public function get fightAnger():int {
        return this._fightAnger;
    }

    public function set isFightAnger(param1:Boolean):void {
        this._isFightAngle = param1;
    }

    public function get isFightAnger():Boolean {
        return this._isFightAngle;
    }

    public function set fightBuffInfoVec(param1:Vector.<FighterBuffInfo>):void {
        this._fightBuffInfoVec = param1;
    }

    public function get fightBuffInfoVec():Vector.<FighterBuffInfo> {
        return this._fightBuffInfoVec;
    }

    public function get catchTime():uint {
        return this._catchTime;
    }

    public function get hp():uint {
        return this._hp;
    }

    public function get maxHp():uint {
        return this._maxHp;
    }

    public function get position():uint {
        return this._position;
    }

    public function get resourceId():uint {
        return this._resourceId;
    }

    public function get skillInfoVec():Vector.<SkillInfo> {
        return this._skillInfoVec;
    }

    public function get userId():uint {
        return this._userId;
    }

    public function get level():uint {
        return this._level;
    }

    public function get maxAnger():uint {
        return this._maxAnger;
    }

    public function set maxHp(param1:uint):void {
        this._maxHp = param1;
    }

    public function set hp(param1:uint):void {
        this._hp = param1;
    }

    public function set position(param1:uint):void {
        this._position = param1;
    }
}
}
