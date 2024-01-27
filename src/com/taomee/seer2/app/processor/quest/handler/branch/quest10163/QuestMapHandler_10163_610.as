package com.taomee.seer2.app.processor.quest.handler.branch.quest10163 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.utils.IDataInput;

public class QuestMapHandler_10163_610 extends QuestMapHandler {


    public function QuestMapHandler_10163_610(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false && SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.doWin();
            }
        }
    }

    private function doWin():void {
        SwapManager.swapItem(925, 1, this.onSwap);
    }

    private function onSwap(param1:IDataInput):void {
        var data:IDataInput = param1;
        DayLimitManager.getDoCount(594, function (param1:int):void {
            if (param1 == 5) {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                QuestManager.completeStep(_quest.id, 1);
            } else {
                ServerMessager.addMessage("你已经获得" + param1 + "/5只卡尼娅之泪！");
            }
        });
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }

    override public function dispose():void {
        super.dispose();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }
}
}
