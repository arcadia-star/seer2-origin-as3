package com.taomee.seer2.app.swap.special {
import com.taomee.seer2.core.net.LittleEndianByteArray;

public class SpecialInfo {


    private var _data:LittleEndianByteArray;

    public function SpecialInfo(...rest) {
        super();
        this._data = new LittleEndianByteArray();
        this._data.writeUnsignedInt(rest[0]);
        var _loc2_:int = 1;
        while (_loc2_ < rest.length) {
            this._data.writeUnsignedInt(rest[_loc2_]);
            _loc2_++;
        }
    }

    public function set data(param1:LittleEndianByteArray):void {
        this._data = param1;
    }

    public function get data():LittleEndianByteArray {
        return this._data;
    }

    public function toSring():String {
        this.data.position = 0;
        var _loc1_:String = "\n\t【";
        var _loc2_:int = int(this.data.readUnsignedInt());
        _loc1_ += _loc2_.toString();
        var _loc3_:int = 0;
        _loc3_ = 0;
        while (_loc3_ < _loc2_) {
            _loc1_ += ", " + this.data.readUnsignedInt().toString();
            _loc3_++;
        }
        this.data.position = 0;
        if (_loc2_ == 0) {
            return "";
        }
        return _loc1_ + "】";
    }
}
}
