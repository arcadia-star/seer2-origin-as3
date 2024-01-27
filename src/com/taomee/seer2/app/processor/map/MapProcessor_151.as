package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.Event;

public class MapProcessor_151 extends TitleMapProcessor {

    private static const MAIN_CARTOON_REWARD_1:String = "mainCartoonReward1";

    private static var _isShow:Boolean;

    private static const FIGHT_DAY:int = 852;


    private var _mainCartoonMC:MovieClip;

    public function MapProcessor_151(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFlower();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_131);
        this.foodPigActInit();
    }

    private function initFlower():void {
        this._mainCartoonMC = _map.content["mainCartoon"] as MovieClip;
        this._mainCartoonMC.addEventListener(MAIN_CARTOON_REWARD_1, this.onMainCartoonReward);
    }

    private function onMainCartoonReward(param1:Event):void {
        this._mainCartoonMC.removeEventListener(MAIN_CARTOON_REWARD_1, this.onMainCartoonReward);
        if (SwapManager.isSwapNumberMax(20)) {
            SwapManager.entrySwap(20);
        }
    }

    private function foodPigActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex <= 9) {
            DayLimitManager.getDoCount(FIGHT_DAY, function (param1:int):void {
                if (!_isShow) {
                    if (param1 >= 10) {
                        ServerMessager.addMessage("给小精灵留点饭团吧，明天再来找他们打！");
                        _isShow = true;
                    }
                }
            });
        }
    }

    override public function dispose():void {
        if (this._mainCartoonMC) {
            this._mainCartoonMC.removeEventListener(MAIN_CARTOON_REWARD_1, this.onMainCartoonReward);
            this._mainCartoonMC = null;
        }
        super.dispose();
    }
}
}
