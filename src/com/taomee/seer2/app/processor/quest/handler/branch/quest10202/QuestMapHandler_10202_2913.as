package com.taomee.seer2.app.processor.quest.handler.branch.quest10202 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10202_2913 extends QuestMapHandler {


    public function QuestMapHandler_10202_2913(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(10202, 2) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep2);
        }
        if (QuestManager.isStepComplete(10202, 3) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep3);
        }
        if (QuestManager.isStepComplete(10202, 2) == true && QuestManager.isStepComplete(10202, 3) == false) {
            this.step3();
        }
        if (QuestManager.isStepComplete(10202, 3) == true && QuestManager.isStepComplete(10202, 4) == false) {
            this.step4();
        }
        if (QuestManager.isStepComplete(10202, 4) == true && QuestManager.isStepComplete(10202, 5) == false) {
            this.completeQuest();
        }
    }

    private function onStep2(param1:QuestEvent):void {
        if (param1.questId == 10202 && param1.stepId == 2) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2);
            this.step3();
        }
    }

    private function step3():void {
        ModuleManager.toggleModule(URLUtil.getAppModule("YiLuDaEnergyPanel"));
    }

    private function onStep3(param1:QuestEvent):void {
        if (param1.questId == 10202 && param1.stepId == 3) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep3);
            this.step4();
        }
    }

    private function step4():void {
        NpcDialog.show(6, "克拉克", [[0, "很好，下面的交给我了。"]], ["Come on"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep4);
            QuestManager.completeStep(10202, 4);
        }]);
    }

    private function onStep4(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep4);
        this.completeQuest();
    }

    private function completeQuest():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10202_3"), function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "啊？发生了什么？那一阵风？"]], ["怎么回事？"], [function ():void {
                NpcDialog.show(6, "克拉克", [[0, "那阵风，就是幻灵骑士团的第二个成员——幻影飓风所为，它把幽冥救走了。剩下的只能靠我们自己了。"]], ["伊鲁达，也没有办法吗？"], [function ():void {
                    NpcDialog.show(6, "克拉克", [[0, "它已经受伤了，我们还是先把它带回去静静养伤吧。"]], ["好，只能这样了。"], [function ():void {
                        QuestManager.completeStep(10202, 5);
                    }]);
                }]);
            }]);
        });
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep3);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep4);
        super.processMapDispose();
    }
}
}
