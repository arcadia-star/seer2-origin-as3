package com.taomee.seer2.app.processor.quest.handler.branch.quest10159 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_10159_810 extends QuestMapHandler {


    public function QuestMapHandler_10159_810(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 98) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.doWin();
            }
        }
    }

    private function doWin():void {
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        QuestManager.completeStep(_quest.id, 1);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        var evt:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_300);
        ServerMessager.addMessage("你获得1块金砖！");
        NpcDialog.show(113, "NONO", [[0, "主人！你已经完成了当前的悬赏令！快去找赏金猎人-金那里领取下一个任务吧！"]], ["现在就去！", "稍后再去。"], [function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 60);
        }]);
    }

    override public function dispose():void {
        super.dispose();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }
}
}
