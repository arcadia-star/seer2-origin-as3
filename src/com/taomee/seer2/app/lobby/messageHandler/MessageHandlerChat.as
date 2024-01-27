package com.taomee.seer2.app.lobby.messageHandler {
import com.taomee.seer2.app.chat.ChatManager;
import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.net.message.IMessageHandler;

public class MessageHandlerChat implements IMessageHandler {


    public function MessageHandlerChat() {
        super();
    }

    public function setup():void {
        Connection.addCommandListener(CommandSet.CHAT_1102, this.onMessage);
    }

    public function onMessage(param1:MessageEvent):void {
        ChatManager.onMessage(new ChatReceivedMessage(param1.message.getRawData()));
    }

    public function dispose():void {
        Connection.removeCommandListener(CommandSet.CHAT_1102, this.onMessage);
    }
}
}
