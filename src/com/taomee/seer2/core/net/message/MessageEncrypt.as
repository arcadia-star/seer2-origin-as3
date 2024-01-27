package com.taomee.seer2.core.net.message {
import seer2.next.fcc.MDecrypt;
import seer2.next.fcc.MEncrypt;

import flash.utils.ByteArray;
import flash.utils.Endian;

public class MessageEncrypt {

    private static var NO_ENCRYPT_LEN:int = 6;


    public function MessageEncrypt() {
        super();
    }

    public static function encrypt(param1:ByteArray):ByteArray {
        var _loc4_:ByteArray = null;
        var _loc2_:int = param1.readUnsignedInt() - NO_ENCRYPT_LEN;
        var _loc3_:int = int(param1.readUnsignedShort());
        (_loc4_ = new ByteArray()).endian = Endian.LITTLE_ENDIAN;
        _loc4_.writeUnsignedInt(0);
        _loc4_.writeShort(_loc3_);
        MEncrypt(param1, _loc2_, _loc4_);
        _loc4_.position = 0;
        _loc4_.writeUnsignedInt(_loc4_.length);
        _loc4_.position = 0;
        return _loc4_;
    }

    public static function decrypt(param1:ByteArray):ByteArray {
        var _loc2_:int = param1.readUnsignedInt() - NO_ENCRYPT_LEN;
        var _loc3_:int = int(param1.readUnsignedShort());
        var _loc4_:ByteArray;
        (_loc4_ = new ByteArray()).endian = Endian.LITTLE_ENDIAN;
        _loc4_.writeUnsignedInt(0);
        _loc4_.writeShort(_loc3_);
        MDecrypt(param1, _loc2_, _loc4_);
        _loc4_.position = 0;
        _loc4_.writeUnsignedInt(_loc4_.length);
        _loc4_.position = 0;
        return _loc4_;
    }
}
}
