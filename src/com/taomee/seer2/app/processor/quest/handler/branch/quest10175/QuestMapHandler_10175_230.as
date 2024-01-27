package com.taomee.seer2.app.processor.quest.handler.branch.quest10175 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10175_230 extends QuestMapHandler {


    public function QuestMapHandler_10175_230(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }

    override public function processMapComplete():void {
        if (isNeedCompleteStep(2)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        }
        if (isNeedCompleteStep(4)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        if (event.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            if (event.stepId == 2) {
                ModuleManager.toggleModule(URLUtil.getAppModule("HuanBeastPanel"), "", "1");
            }
            if (event.stepId == 4) {
                MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10175_0"), 4, [[1, 0]], function ():void {
                });
            }
        }
    }
}
}
