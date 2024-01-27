package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.display.MovieClip;
import flash.events.Event;

public class MapProcessor_281 extends MapProcessor {


    private const FIREREWARD281_1:String = "fireReward281_1";

    private const FIREREWARD281_2:String = "fireReward281_2";

    private var fire1MC:MovieClip;

    private var fire2MC:MovieClip;

    public function MapProcessor_281(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFire();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_168);
    }

    private function initFire():void {
        this.fire1MC = _map.content["fire1"] as MovieClip;
        this.fire2MC = _map.content["fire2"] as MovieClip;
        this.fire1MC.addEventListener(this.FIREREWARD281_1, this.onfireReward1);
        this.fire2MC.addEventListener(this.FIREREWARD281_2, this.onfireReward2);
    }

    private function onfireReward1(param1:Event):void {
        this.fire1MC.removeEventListener(this.FIREREWARD281_1, this.onfireReward1);
        if (SwapManager.isSwapNumberMax(32)) {
            SwapManager.entrySwap(32);
        }
    }

    private function onfireReward2(param1:Event):void {
        this.fire2MC.removeEventListener(this.FIREREWARD281_2, this.onfireReward2);
        if (SwapManager.isSwapNumberMax(33)) {
            SwapManager.entrySwap(33);
        }
    }

    override public function dispose():void {
        if (this.fire1MC) {
            this.fire1MC.removeEventListener(this.FIREREWARD281_1, this.onfireReward1);
            this.fire1MC = null;
        }
        if (this.fire2MC) {
            this.fire2MC.removeEventListener(this.FIREREWARD281_2, this.onfireReward2);
            this.fire2MC = null;
        }
    }
}
}
