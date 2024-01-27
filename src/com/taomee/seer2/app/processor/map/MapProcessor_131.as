package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.Event;

public class MapProcessor_131 extends TitleMapProcessor {

    private static const FRUITS_REWARD_1:String = "fruitsReward1";


    private var _fruitsMC:MovieClip;

    public function MapProcessor_131(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFruits();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_127);
    }

    private function initFruits():void {
        this._fruitsMC = _map.content["fruits"] as MovieClip;
        this._fruitsMC.addEventListener(FRUITS_REWARD_1, this.onFruitsReward);
    }

    private function onFruitsReward(param1:Event):void {
        this._fruitsMC.removeEventListener(FRUITS_REWARD_1, this.onFruitsReward);
        if (SwapManager.isSwapNumberMax(16)) {
            SwapManager.entrySwap(16);
        }
    }

    override public function dispose():void {
        if (this._fruitsMC) {
            this._fruitsMC.removeEventListener(FRUITS_REWARD_1, this.onFruitsReward);
            this._fruitsMC = null;
        }
        super.dispose();
    }
}
}
