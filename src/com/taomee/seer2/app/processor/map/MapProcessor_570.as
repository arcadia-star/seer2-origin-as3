package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.display.MovieClip;
import flash.events.Event;

public class MapProcessor_570 extends MapProcessor {

    private static const FRUITS_REWARD570_0:String = "bingReward570_0";


    private var _bing1:MovieClip;

    public function MapProcessor_570(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initBingSwap();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_178);
    }

    private function initBingSwap():void {
        this._bing1 = _map.front["petAnimation"];
        this._bing1.addEventListener(FRUITS_REWARD570_0, this.onSwap1);
    }

    private function onSwap1(param1:Event):void {
        this._bing1.removeEventListener(FRUITS_REWARD570_0, this.onSwap1);
        if (SwapManager.isSwapNumberMax(215)) {
            SwapManager.entrySwap(215);
        }
    }

    override public function dispose():void {
        if (this._bing1) {
            this._bing1.removeEventListener(FRUITS_REWARD570_0, this.onSwap1);
            this._bing1 = null;
        }
    }
}
}
