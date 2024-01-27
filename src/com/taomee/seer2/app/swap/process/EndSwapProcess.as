package com.taomee.seer2.app.swap.process {
import com.taomee.seer2.app.swap.event.SwapEventDispatcher;
import com.taomee.seer2.app.swap.sharedObject.SwapSharedObject;

import flash.events.Event;
import flash.events.EventDispatcher;

public class EndSwapProcess extends EventDispatcher {


    public function EndSwapProcess() {
        super();
        this.setSharedObjectNumber();
        this.sendEnd();
    }

    private function setSharedObjectNumber():void {
        SwapSharedObject.instance.setRewardNum();
    }

    private function sendEnd():void {
        SwapEventDispatcher.dispatchEvent(new Event(SwapEventDispatcher.SWAP_END));
    }
}
}
