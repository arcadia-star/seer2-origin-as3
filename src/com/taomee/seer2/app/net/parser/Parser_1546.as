package com.taomee.seer2.app.net.parser {
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.core.net.LittleEndianByteArray;

public class Parser_1546 {


    private var _petInfo:PetInfo;

    public function Parser_1546(param1:LittleEndianByteArray, param2:PetInfo) {
        super();
        this._petInfo = param2;
        this._petInfo.catchTime = param1.readUnsignedInt();
        this._petInfo.sex = param1.readUnsignedByte();
        this._petInfo.level = param1.readUnsignedShort();
        this._petInfo.hp = param1.readUnsignedInt();
        this._petInfo.maxHp = param1.readUnsignedInt();
        this._petInfo.atk = param1.readUnsignedShort();
        this._petInfo.specialAtk = param1.readUnsignedShort();
        this._petInfo.defence = param1.readUnsignedShort();
        this._petInfo.specialDefence = param1.readUnsignedShort();
        this._petInfo.speed = param1.readUnsignedShort();
        this._petInfo.expToLevelUp = param1.readUnsignedInt();
        this._petInfo.character = param1.readUnsignedShort();
        this._petInfo.learningInfo.pointUnused = param1.readUnsignedShort();
        this._petInfo.potential = param1.readUnsignedInt();
    }
}
}
