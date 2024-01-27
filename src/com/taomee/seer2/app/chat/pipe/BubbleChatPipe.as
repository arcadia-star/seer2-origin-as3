package com.taomee.seer2.app.chat.pipe {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.chat.constant.ChatPipeType;
import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
import com.taomee.seer2.app.chat.events.PublicChatEvent;

import org.taomee.manager.EventManager;

public class BubbleChatPipe implements IChatPipe {


    private var _type:int;

    public function BubbleChatPipe() {
        super();
        this.type = ChatPipeType.PUBLIC;
    }

    public function set type(param1:int):void {
        this._type = param1;
    }

    public function get type():int {
        return this._type;
    }

    public function onMessage(param1:ChatReceivedMessage):void {
        var _loc2_:Actor = ActorManager.getActorById(param1.senderId);
        if (_loc2_) {
            _loc2_.talk(param1.message);
            EventManager.dispatchEvent(new PublicChatEvent(PublicChatEvent.MESSAGE, param1));
        }
    }
}
}
