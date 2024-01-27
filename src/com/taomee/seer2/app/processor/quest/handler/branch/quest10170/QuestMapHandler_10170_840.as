package com.taomee.seer2.app.processor.quest.handler.branch.quest10170 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_10170_840 extends QuestMapHandler {


    public function QuestMapHandler_10170_840(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(1)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            if (param1.stepId == 1) {
                SceneManager.changeScene(SceneType.LOBBY, 160);
            }
        }
    }
}
}
