package com.taomee.seer2.app.notify.data.notice {
import com.taomee.seer2.app.chat.ChatManager;
import com.taomee.seer2.app.chat.data.ChatReceivedMessage;

public class ChatNotice extends Notice {


    private var _messageVec:Vector.<ChatReceivedMessage>;

    public function ChatNotice(param1:uint) {
        super(NoticeType.CHAT, param1);
        this._messageVec = new Vector.<ChatReceivedMessage>();
    }

    public function addMessage(param1:ChatReceivedMessage):void {
        this._messageVec.push(param1);
    }

    override public function process():void {
        ChatManager.chatPanelPipe.show(userId, this._messageVec);
    }
}
}
