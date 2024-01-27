package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activity.processor.FightNana;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class MapProcessor_900 extends TitleMapProcessor {


    private var _fightHrader:FightNana;

    public function MapProcessor_900(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFight();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_188);
        _map.content["smokeBtn"].visible = false;
        DayLimitListManager.getDaylimitList([5241], function callback(param1:DayLimitListInfo):void {
            if (param1.getCount(5241) == 0) {
                _map.content["smokeBtn"].visible = true;
            }
        });
        TooltipManager.addCommonTip(_map.content["smokeBtn"], "烟尘蒸汽团");
        _map.content["smokeBtn"].addEventListener(MouseEvent.CLICK, this.onSmokeClick);
    }

    private function onSmokeClick(param1:*):void {
        var e:* = param1;
        _map.content["smokeBtn"].visible = false;
        SwapManager.swapItem(4572, 1, function success(param1:IDataInput):void {
            new SwapInfo(param1);
        }, function failed(param1:uint):void {
        });
    }

    private function initFight():void {
        this._fightHrader = new FightNana();
    }

    override public function dispose():void {
        if (this._fightHrader) {
            this._fightHrader.dispose();
        }
        TooltipManager.remove(_map.content["smokeBtn"]);
        _map.content["smokeBtn"].removeEventListener(MouseEvent.CLICK, this.onSmokeClick);
        super.dispose();
    }
}
}
