package com.taomee.seer2.app.chat.data {
import com.taomee.seer2.core.net.LittleEndianByteArray;

public class ChatSendMessage {

    public static const MAX_DATA_LEN:int = 135;


    private var _targetUserId:int;

    private var _message:String;

    public function ChatSendMessage(param1:int, param2:String) {
        super();
        this._targetUserId = param1;
        this._message = param2;
    }

    public function get targetUserId():int {
        return this._targetUserId;
    }

    public function get message():String {
        return this._message;
    }

    public function pack():LittleEndianByteArray {
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc2_.writeUTFBytes(this._message);
        _loc2_.position = 0;
        var _loc3_:int = int(_loc2_.length);
        if (_loc2_.length > MAX_DATA_LEN) {
            _loc3_ = MAX_DATA_LEN;
        }
        _loc1_.writeUnsignedInt(this._targetUserId);
        _loc1_.writeUnsignedInt(_loc3_);
        _loc1_.writeBytes(_loc2_, 0, _loc3_);
        return _loc1_;
    }
}
}
