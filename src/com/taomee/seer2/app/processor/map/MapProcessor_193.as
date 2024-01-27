package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.gameRule.spt.SptAKanasiSupport;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.Event;

public class MapProcessor_193 extends TitleMapProcessor {

    private static const FLOWER_REWARD_3:String = "flowerReward3";


    private var _flowerSing:MovieClip;

    private var _passCartoon:MovieClip;

    public function MapProcessor_193(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initPassCartoon();
        this.reward();
        SptAKanasiSupport.getInstance().init(_map);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_141);
    }

    private function initPassCartoon():void {
        this._passCartoon = _map.content["cartoons"] as MovieClip;
        this._passCartoon.addEventListener(Event.ENTER_FRAME, this.onPassEnterFrame);
    }

    private function onPassEnterFrame(param1:Event):void {
        if (this._passCartoon.currentFrame == this._passCartoon.totalFrames) {
            this._passCartoon.removeEventListener(Event.ENTER_FRAME, this.onPassEnterFrame);
            DisplayObjectUtil.removeFromParent(_map.path["pathMask"]);
            _map.recalculatePathData();
        }
    }

    private function reward():void {
        this._flowerSing = _map.ground["flowerSing"];
        this._flowerSing.addEventListener(FLOWER_REWARD_3, this.onFlowerReward);
    }

    private function onFlowerReward(param1:Event):void {
        if (this._flowerSing) {
            this._flowerSing.removeEventListener(FLOWER_REWARD_3, this.onFlowerReward);
            if (SwapManager.isSwapNumberMax(8)) {
                SwapManager.entrySwap(8);
            }
        }
    }

    override public function dispose():void {
        if (this._flowerSing.hasEventListener(FLOWER_REWARD_3)) {
            this._flowerSing.removeEventListener(FLOWER_REWARD_3, this.onFlowerReward);
        }
        this._flowerSing = null;
        if (this._passCartoon.hasEventListener(Event.ENTER_FRAME)) {
            this._passCartoon.removeEventListener(Event.ENTER_FRAME, this.onPassEnterFrame);
        }
        this._passCartoon = null;
        SptAKanasiSupport.getInstance().dispose();
        super.dispose();
    }
}
}
