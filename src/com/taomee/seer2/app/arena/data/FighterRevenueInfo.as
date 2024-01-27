package com.taomee.seer2.app.arena.data {
import com.taomee.seer2.app.pet.data.SkillInfo;

import flash.utils.IDataInput;

public class FighterRevenueInfo {


    private var _id:uint;

    private var _sex:uint;

    private var _level:uint;

    private var _hp:uint;

    private var _maxHp:uint;

    private var _atk:uint;

    private var _specialAtk:uint;

    private var _defence:uint;

    private var _specialDefence:uint;

    private var _speed:uint;

    private var _character:uint;

    private var _levelUpNeededExp:uint;

    private var _gainedExp:uint;

    private var _skillInfoVec:Vector.<SkillInfo>;

    public function FighterRevenueInfo(param1:IDataInput) {
        super();
        this._id = param1.readUnsignedInt();
        this._sex = param1.readUnsignedByte();
        this._level = param1.readUnsignedShort();
        this._hp = param1.readUnsignedInt();
        this._maxHp = param1.readUnsignedInt();
        this._atk = param1.readUnsignedShort();
        this._specialAtk = param1.readUnsignedShort();
        this._defence = param1.readUnsignedShort();
        this._specialDefence = param1.readUnsignedShort();
        this._speed = param1.readUnsignedShort();
        this._levelUpNeededExp = param1.readUnsignedInt();
        this._character = param1.readUnsignedShort();
        this._gainedExp = param1.readUnsignedInt();
        this._skillInfoVec = new Vector.<SkillInfo>();
        var _loc2_:int = int(param1.readUnsignedInt());
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            this._skillInfoVec.push(new SkillInfo(param1.readUnsignedInt()));
            _loc3_++;
        }
    }

    public function get specialAtk():uint {
        return this._specialAtk;
    }

    public function get specialDefence():uint {
        return this._specialDefence;
    }

    public function get speed():uint {
        return this._speed;
    }

    public function get character():uint {
        return this._character;
    }

    public function get levelUpNeededExp():uint {
        return this._levelUpNeededExp;
    }

    public function get skillInfoVec():Vector.<SkillInfo> {
        return this._skillInfoVec;
    }

    public function get id():uint {
        return this._id;
    }

    public function get level():uint {
        return this._level;
    }

    public function get atk():uint {
        return this._atk;
    }

    public function get defence():uint {
        return this._defence;
    }

    public function get gainedExp():uint {
        return this._gainedExp;
    }

    public function get maxHp():uint {
        return this._maxHp;
    }
}
}
