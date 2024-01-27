package com.taomee.seer2.app.processor.quest.handler.branch.quest10164 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10164_840 extends QuestMapHandler {


    public function QuestMapHandler_10164_840(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(3)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        }
        if (isNeedCompleteStep(5)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        if (questID == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            if (param1.stepId == 5) {
                SceneManager.changeScene(SceneType.LOBBY, 160);
            }
            if (param1.stepId == 3) {
                ModuleManager.toggleModule(URLUtil.getAppModule("MaiBeastPanel"), "", "2");
            }
        }
    }
}
}
