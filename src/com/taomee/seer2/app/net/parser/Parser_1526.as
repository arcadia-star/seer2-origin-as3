package com.taomee.seer2.app.net.parser {
import com.taomee.seer2.app.pet.data.PetInfo;

import flash.utils.IDataInput;

public class Parser_1526 {


    public var _petTime:uint;

    public var _maxHp:uint;

    public var _atk:uint;

    public var _specialAtk:uint;

    public var _defence:uint;

    public var _specialDefence:uint;

    public var _speed:uint;

    public var _hp:uint;

    public function Parser_1526(param1:IDataInput) {
        super();
        this._petTime = param1.readUnsignedInt();
        this._maxHp = param1.readUnsignedInt();
        this._atk = param1.readUnsignedShort();
        this._specialAtk = param1.readUnsignedShort();
        this._defence = param1.readUnsignedShort();
        this._specialDefence = param1.readUnsignedShort();
        this._speed = param1.readUnsignedShort();
        this._hp = param1.readUnsignedInt();
    }

    public function petSetInfo(param1:PetInfo):void {
        if (param1.catchTime == this._petTime) {
            param1.maxHp = this._maxHp;
            param1.atk = this._atk;
            param1.specialAtk = this._specialAtk;
            param1.defence = this._defence;
            param1.specialDefence = this._specialDefence;
            param1.speed = this._speed;
            param1.hp = this._hp;
        }
    }
}
}
