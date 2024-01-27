package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.getMoneyRideHorseAct.GetMoneyRideHorseAct;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.event.SwapEventDispatcher;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

public class MapProcessor_122 extends TitleMapProcessor {


    private var _birdAnimation:MovieClip;

    private var _birdClickCount:int = 0;

    private var _timeout:uint = 0;

    private var _getMoneyRideHorseAct:GetMoneyRideHorseAct;

    public function MapProcessor_122(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initBird();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_122);
        this._getMoneyRideHorseAct = new GetMoneyRideHorseAct(_map);
    }

    private function initBird():void {
        this._birdAnimation = _map.content["birdAnimation"];
        initInteractor(this._birdAnimation);
        this._birdAnimation.addEventListener(MouseEvent.CLICK, this.onBirdClick);
    }

    private function onBirdClick(param1:MouseEvent):void {
        if (this._birdClickCount == 0) {
            ++this._birdClickCount;
            this._birdAnimation.gotoAndStop(2);
        } else if (this._birdClickCount == 1) {
            ++this._birdClickCount;
            this._birdAnimation.gotoAndStop(3);
            this._timeout = setTimeout(this.reward, 1500);
            this._birdAnimation.removeEventListener(MouseEvent.CLICK, this.onBirdClick);
        }
    }

    private function reward():void {
        if (SwapManager.isSwapNumberMax(14)) {
            SwapEventDispatcher.addEventListener(SwapEventDispatcher.SWAP_END, this.onSwapEnd);
            SwapManager.entrySwap(14);
        }
    }

    private function onSwapEnd(param1:Event):void {
        clearTimeout(this._timeout);
    }

    override public function dispose():void {
        if (this._timeout != 0) {
            clearTimeout(this._timeout);
            this._timeout = 0;
        }
        if (Boolean(this._birdAnimation) && this._birdAnimation.hasEventListener(MouseEvent.CLICK) == false) {
            this._birdAnimation.removeEventListener(MouseEvent.CLICK, this.onBirdClick);
            this._birdAnimation = null;
        }
        if (this._getMoneyRideHorseAct) {
            this._getMoneyRideHorseAct.dispose();
            this._getMoneyRideHorseAct = null;
        }
        super.dispose();
    }
}
}
