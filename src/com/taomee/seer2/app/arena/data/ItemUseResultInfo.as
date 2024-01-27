package com.taomee.seer2.app.arena.data {
import flash.utils.IDataInput;

public class ItemUseResultInfo {


    public var userId:uint;

    public var fighterId:uint;

    private var _side:uint;

    private var _skillId:uint;

    private var _position:uint;

    private var _hp:uint;

    private var _maxHp:uint;

    private var _anger:uint;

    private var _isDying:Boolean;

    private var _atkLevel:uint;

    private var _defenceLevel:uint;

    private var _specialAtkLevel:uint;

    private var _specialDefenceLevel:uint;

    private var _speedLevel:uint;

    private var _buffInfoVec:Vector.<FighterBuffInfo>;

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
