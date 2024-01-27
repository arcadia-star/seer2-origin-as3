package com.taomee.seer2.app.serverBuffer {
import com.taomee.seer2.core.log.Logger;
import com.taomee.seer2.core.net.LittleEndianByteArray;

public class ServerBuffer {

    private static const STARTPOSITION:int = 4;


    private var _serverBufferType:uint = 0;

    private var _data:LittleEndianByteArray;

    private var _logger:Logger;

    public function ServerBuffer(param1:LittleEndianByteArray, param2:uint) {
        super();
        this._serverBufferType = param2;
        this._data = param1;
        this._logger = Logger.getLogger("ServerBuffer");
    }

    public function readString(param1:uint):String {
        var _loc2_:uint = uint(STARTPOSITION + param1);
        this._data.position = _loc2_;
        return String(this._data.readUTF());
    }

    public function writeString(param1:uint, param2:String):void {
        this._data.position = STARTPOSITION + param1;
        this._data.writeUTF(param2);
    }

    public function readDataAtPostion(param1:uint):int {
        var _loc2_:uint = uint(STARTPOSITION + param1);
        this._data.position = _loc2_;
        return uint(this._data.readByte());
    }

    public function readDataAtPostionGetInt(param1:uint):uint {
        var _loc2_:uint = uint(STARTPOSITION + param1);
        this._data.position = _loc2_;
        return uint(this._data.readInt());
    }

    public function writeDataAtPostion(param1:uint, param2:int):void {
        this._data.position = STARTPOSITION + param1;
        this._data.writeByte(param2);
    }

    public function writeDataAtUint(param1:uint, param2:int):void {
        this._data.position = STARTPOSITION + param1;
        this._data.writeInt(param2);
    }

    public function get data():LittleEndianByteArray {
        return this._data;
    }

    public function get type():int {
        return this._serverBufferType;
    }

    public function printDataInfo():void {
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc1_.writeBytes(this._data);
        var _loc2_:uint = uint(_loc1_.length);
        _loc1_.position = 0;
        var _loc3_:String = "";
        var _loc4_:uint = 0;
        while (_loc4_ < _loc2_) {
            _loc3_ += _loc1_.readByte() + " ";
            _loc4_++;
        }
        this._logger.info("###########################  ServerBufferData ########################");
        this._logger.info("ServerBufferType :" + ServerBufferType.serverTypeName(this._serverBufferType));
        this._logger.info("Length           :" + this._data.length);
        this._logger.info("Data             :" + _loc3_);
    }
}
}
