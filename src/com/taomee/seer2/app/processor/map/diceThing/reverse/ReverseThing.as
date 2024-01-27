package com.taomee.seer2.app.processor.map.diceThing.reverse {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;

public class ReverseThing extends BaseDiceThing {


    public function ReverseThing(param1:DiceThingInfo) {
        super(param1);
    }

    override public function setUpThing():void {
        eventInfo.moveTile = thingInfo.moveTile;
        if (thingInfo.currentSeat + eventInfo.moveTile < 0) {
            eventInfo.moveTile = -thingInfo.currentSeat;
        }
        ServerMessager.addMessage("额……有妖气！你被一种诡异的力量击中，倒退" + Math.abs(eventInfo.moveTile) + "格");
        this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, eventInfo));
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
