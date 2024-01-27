package com.taomee.seer2.app.actor.attach {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.bubble.Bubble;
import com.taomee.seer2.app.actor.bubble.BubblePool;

import flash.events.Event;

public class ChatActorAttach implements IActorAttach {


    private var _chatBubble:Bubble;

    private var _actor:Actor;

    public function ChatActorAttach() {
        super();
    }

    public function attach(param1:Actor):void {
        this._actor = param1;
    }

    public function detach():void {
        this.checkInChatBubble();
        this._actor = null;
    }

    public function get type():String {
        return ActorAttachType.CHAT;
    }

    public function excute(param1:*):void {
        this.checkInChatBubble();
        this._chatBubble = BubblePool.checkOut();
        this._chatBubble.show(param1, this._actor.getInfo().vipInfo.isVip());
        this._chatBubble.addEventListener(Event.CLOSE, this.onBubbleDisappear);
        this._chatBubble.y = -25 - this._chatBubble.height;
        this._actor.addChild(this._chatBubble);
    }

    private function onBubbleDisappear(param1:Event):void {
        this.checkInChatBubble();
    }

    private function checkInChatBubble():void {
        if (this._chatBubble != null) {
            this._chatBubble.removeEventListener(Event.CLOSE, this.onBubbleDisappear);
            BubblePool.checkIn(this._chatBubble);
            this._actor.removeChild(this._chatBubble);
            this._chatBubble = null;
        }
    }
}
}
