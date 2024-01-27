package com.taomee.seer2.app.processor.map.diceThing {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEventInfo;

import flash.events.EventDispatcher;

public class BaseDiceThing extends EventDispatcher {


    protected var thingInfo:DiceThingInfo;

    protected var eventInfo:DiceThingEventInfo;

    public function BaseDiceThing(param1:DiceThingInfo) {
        super();
        this.thingInfo = param1;
        this.eventInfo = new DiceThingEventInfo();
        this.eventInfo.currentSeat = this.thingInfo.currentSeat;
    }

    public function setUpThing():void {
    }

    public function dispose():void {
        this.thingInfo = null;
        this.eventInfo = null;
    }
}
}
