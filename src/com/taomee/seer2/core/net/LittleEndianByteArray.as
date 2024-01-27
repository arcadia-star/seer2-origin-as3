package com.taomee.seer2.core.net {
import flash.utils.ByteArray;
import flash.utils.Endian;

public class LittleEndianByteArray extends ByteArray {


    public function LittleEndianByteArray() {
        super();
        endian = Endian.LITTLE_ENDIAN;
    }

    public static function writeIntergerAsUnsignedByte(param1:int):LittleEndianByteArray {
        var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc2_.writeByte(param1);
        return _loc2_;
    }

    public static function writeIntergerAsUnsignedShort(param1:int):LittleEndianByteArray {
        var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc2_.writeShort(param1);
        return _loc2_;
    }

    public static function writeIntergerAsUnsignedInt(param1:int):LittleEndianByteArray {
        var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc2_.writeUnsignedInt(param1);
        return _loc2_;
    }

    public function clone():LittleEndianByteArray {
        this.position = 0;
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        this.readBytes(_loc1_);
        _loc1_.position = 0;
        this.position = 0;
        return _loc1_;
    }
}
}
