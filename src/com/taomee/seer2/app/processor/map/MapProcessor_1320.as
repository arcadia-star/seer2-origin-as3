package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.Event;

public class MapProcessor_1320 extends TitleMapProcessor {

    private static const MUSHROOM_REWARD_2_A:String = "mushroomReward2A";


    private var _mushroomMC:MovieClip;

    public function MapProcessor_1320(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFruits();
    }

    private function initFruits():void {
        this._mushroomMC = _map.content["mushroom3"] as MovieClip;
        this._mushroomMC.addEventListener(MUSHROOM_REWARD_2_A, this.onMushroomReward);
    }

    private function onMushroomReward(param1:Event):void {
        this._mushroomMC.removeEventListener(MUSHROOM_REWARD_2_A, this.onMushroomReward);
        if (SwapManager.isSwapNumberMax(18)) {
            SwapManager.entrySwap(18);
        }
    }

    override public function dispose():void {
        if (this._mushroomMC) {
            this._mushroomMC.removeEventListener(MUSHROOM_REWARD_2_A, this.onMushroomReward);
            this._mushroomMC = null;
        }
        super.dispose();
    }
}
}
