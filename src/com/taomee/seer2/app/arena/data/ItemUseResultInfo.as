package com.taomee.seer2.app.arena.data {
import flash.utils.IDataInput;

public class ItemUseResultInfo {


    public var userId:uint;

    public var fighterId:uint;

    public var _side:uint;

    public var _skillId:uint;

    public var _position:uint;

    public var _hp:uint;

    public var _maxHp:uint;

    public var _anger:uint;

    public var _isDying:Boolean;

    public var _atkLevel:uint;

    public var _defenceLevel:uint;

    public var _specialAtkLevel:uint;

    public var _specialDefenceLevel:uint;

    public var _speedLevel:uint;

    public var _buffInfoVec:Vector.<FighterBuffInfo>;

    public function ItemUseResultInfo(param1:IDataInput) {
        super();
        this._side = param1.readUnsignedByte();
        this.userId = param1.readUnsignedInt();
        this.fighterId = param1.readUnsignedInt();
        this._skillId = param1.readUnsignedInt();
        this._position = param1.readUnsignedByte();
        this._hp = param1.readUnsignedInt();
        this._maxHp = param1.readUnsignedInt();
        this._anger = param1.readUnsignedShort();
        this._isDying = param1.readUnsignedByte() == 1;
        this._atkLevel = param1.readUnsignedByte();
        this._defenceLevel = param1.readUnsignedByte();
        this._specialAtkLevel = param1.readUnsignedByte();
        this._specialDefenceLevel = param1.readUnsignedByte();
        this._speedLevel = param1.readUnsignedByte();
        this._buffInfoVec = new Vector.<FighterBuffInfo>();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            this._buffInfoVec.push(new FighterBuffInfo(param1));
            _loc3_++;
        }
    }

    public function get anger():uint {
        return this._anger;
    }

    public function get hp():uint {
        return this._hp;
    }
}
}
