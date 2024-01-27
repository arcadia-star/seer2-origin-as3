package com.taomee.seer2.app.chat.pipe {
import com.taomee.seer2.app.chat.data.ChatReceivedMessage;

public interface IChatPipe {


    function set type(param1:int):void;

    function get type():int;

    function onMessage(param1:ChatReceivedMessage):void;
}
}
