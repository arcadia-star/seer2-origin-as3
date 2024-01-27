package com.taomee.seer2.app.processor.map.diceThing.chance {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEventInfo;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.module.ModuleManager;

import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class CaiQuanThing extends ChanceThing {


    public function CaiQuanThing(param1:DiceThingInfo) {
        super(param1);
        thingInfo.id = 0;
        thingInfo.isMee = true;
    }

    override protected function setUpGame(param1:MouseEvent):void {
        super.setUpGame(param1);
        ModuleManager.showAppModule("CaiQuanGamePanel", {"func": this.gameHandle});
    }

    private function gameHandle(param1:int):void {
        if (param1 != 0) {
            SwapManager.swapItem(2762, 1, this.onSwapSuccess, null, new SpecialInfo(1, 99));
        } else {
            this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, new DiceThingEventInfo()));
        }
    }

    private function onSwapSuccess(param1:IDataInput):void {
        var _loc2_:SwapInfo = new SwapInfo(param1, false);
        this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER, new DiceThingEventInfo()));
    }
}
}
