package com.taomee.seer2.app.chat.data {
import flash.utils.IDataInput;

public class ChatReceivedMessage {


    private var _senderId:uint;

    private var _senderNick:String;

    private var _receiverId:uint;

    private var _pipeType:int;

    private var _msgLen:int;

    private var _msg:String;

    public function ChatReceivedMessage(param1:IDataInput) {
        super();
        this._senderId = param1.readUnsignedInt();
        this._senderNick = param1.readUTFBytes(16);
        this._receiverId = param1.readUnsignedInt();
        this._pipeType = param1.readUnsignedByte();
        this._msgLen = param1.readUnsignedInt();
        this._msg = param1.readUTFBytes(this._msgLen);
    }

    public function get senderId():uint {
        return this._senderId;
    }

    public function get senderNick():String {
        return this._senderNick;
    }

    public function get receiverId():uint {
        return this._receiverId;
    }

    public function get pipeType():int {
        return this._pipeType;
    }

    public function get message():String {
        return this._msg;
    }

    public function set message(param1:String):void {
        this._msg = param1;
    }
}
}
