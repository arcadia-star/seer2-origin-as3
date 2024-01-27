package com.taomee.seer2.core.net.message {
import seer2.next.fcc.CLibInit;

import flash.utils.ByteArray;
import flash.utils.Endian;

public class RequestPacker {

    private static var _sequenceNum:int = 0;

    private static var _descObj:Object;


    public function RequestPacker() {
        super();
    }

    public static function pack(param1:uint, param2:uint, param3:Array, param4:String = null):ByteArray {
        if (param4 == null) {
            param4 = Endian.LITTLE_ENDIAN;
        }
        var _loc5_:ByteArray;
        (_loc5_ = new ByteArray()).endian = param4;
        serializeBinary(_loc5_, param3);
        var _loc6_:ByteArray = packHead(param1, param2, _loc5_, _loc5_.length, param4);
        var _loc7_:ByteArray;
        (_loc7_ = new ByteArray()).endian = param4;
        _loc7_.writeBytes(_loc6_);
        _loc7_.writeBytes(_loc5_);
        _loc7_.position = 0;
        return MessageEncrypt.encrypt(_loc7_);
    }

    private static function serializeBinary(param1:ByteArray, param2:Array):void {
        var _loc3_:* = undefined;
        for each(_loc3_ in param2) {
            if (_loc3_ is Array) {
                serializeBinary(param1, _loc3_);
            } else if (_loc3_ is String) {
                param1.writeUTFBytes(_loc3_);
            } else if (_loc3_ is ByteArray) {
                param1.writeBytes(_loc3_);
            } else {
                param1.writeUnsignedInt(_loc3_);
            }
        }
    }

    private static function packHead(param1:uint, param2:uint, param3:ByteArray, param4:int, param5:String):ByteArray {
        var _loc8_:int = 0;
        var _loc9_:int = 0;
        var _loc6_:ByteArray;
        (_loc6_ = new ByteArray()).endian = param5;
        _loc6_.writeUnsignedInt(Message.HEAD_LENGTH + param4);
        _loc6_.writeShort(param2);
        _loc6_.writeUnsignedInt(param1);
        _loc6_.writeInt(generateNewSequenceNum(param2, Message.HEAD_LENGTH + param4, _sequenceNum));
        var _loc7_:uint = 0;
        _loc6_.position = 0;
        _loc9_ = int(_loc6_.bytesAvailable);
        _loc8_ = 0;
        while (_loc8_ < _loc9_) {
            _loc7_ += _loc6_.readUnsignedByte();
            _loc8_++;
        }
        param3.position = 0;
        _loc9_ = param4;
        _loc8_ = 0;
        while (_loc8_ < _loc9_) {
            _loc7_ += param3.readUnsignedByte();
            _loc8_++;
        }
        _loc7_ %= 100000;
        _loc6_.writeInt(_loc7_);
        return _loc6_;
    }

    private static function generateNewSequenceNum(param1:uint, param2:int, param3:int):int {
//         var _loc4_:CLibInit = null;
//         if(_descObj == null)
//         {
//            _loc4_ = new CLibInit();
//            _descObj = _loc4_.init();
//         }
        _sequenceNum = CLibInit.Desc(param1, param2, param3);
        return _sequenceNum;
    }
}
}
