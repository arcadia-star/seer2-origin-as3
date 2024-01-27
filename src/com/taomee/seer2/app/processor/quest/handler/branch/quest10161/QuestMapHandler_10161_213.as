package com.taomee.seer2.app.processor.quest.handler.branch.quest10161 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10161_213 extends QuestMapHandler {


    public function QuestMapHandler_10161_213(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(2)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        }
        if (isNeedCompleteStep(3)) {
            this.initStep3();
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == 10161 && param1.stepId == 2) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10161_0"), this.initStep3);
        }
    }

    private function initStep3():void {
        NpcDialog.show(27, "占卜婆婆", [[0, "看见了吗？可怜的脉灵兽就这样年复一年的失去控制，周围的精灵也跟着遭殃了。"]], ["   我想我得先帮助那些精灵 "], [function ():void {
            NpcDialog.show(27, "占卜婆婆", [[0, "对的，你先得去拯救那些被黑色血液侵蚀的精灵，否则黑色血液会继续侵蚀其他精灵。"]], ["   我这就去 "], [function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                QuestManager.completeStep(questID, 3);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 10161) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
            ModuleManager.toggleModule(URLUtil.getAppModule("BagginsLogPanel"));
        }
    }
}
}
