package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.arena.data.RevenueInfo;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.FightResultPanelWrapper;
import com.taomee.seer2.app.manager.PetExperenceHelper;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1140;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.core.net.MessageEvent;

import flash.events.Event;

import org.taomee.bean.BaseBean;

public class PetLevelUpBean extends BaseBean {

    public static var stopLevelUp:Boolean = false;


    private var _fightResultPanelWrapper:FightResultPanelWrapper;

    public function PetLevelUpBean() {
        super();
        PetInfoManager.addEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onEventStart);
        finish();
    }

    private function onEventStart(param1:MessageEvent):void {
        var evt:MessageEvent = param1;
        var parser:Parser_1140 = new Parser_1140(evt.message.getRawDataCopy());
        if (parser.id == 1 && parser.index == 23) {
            NpcDialog.show(505, "光系精灵帕拉丁同学", [[3, "帕拉丁军团已经跟随辛迪船长多年。如果你能用实力证明你是最值得船长信赖的赛尔，我愿意跟随你去执行更多的任务！"]], ["（我会好好运用的！）"], [function ():void {
                FightManager.startFightWithWild(143);
            }]);
        }
    }

    private function onPetLevelUp(param1:PetInfoEvent):void {
        if (stopLevelUp) {
            return;
        }
        var _loc2_:FightResultInfo = param1.content.resultInfo;
        var _loc3_:RevenueInfo = param1.content.revenueInfo;
        if (_loc2_.endReason == PetExperenceHelper.MAIN_TASK_REWARD) {
            this._fightResultPanelWrapper = new FightResultPanelWrapper();
            this._fightResultPanelWrapper.addEventListener(Event.COMPLETE, this.onFightResultPanelClosed);
            this._fightResultPanelWrapper.show(PetInfoManager.getAllBagPetInfo(), _loc3_, _loc2_);
        }
    }

    private function onFightResultPanelClosed(param1:Event):void {
        this._fightResultPanelWrapper.removeEventListener(Event.COMPLETE, this.onFightResultPanelClosed);
        this._fightResultPanelWrapper = null;
    }
}
}
