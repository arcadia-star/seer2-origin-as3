package com.taomee.seer2.app.processor.quest.handler.activity.quest30006 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_30006_10 extends QuestMapHandler {


    public function QuestMapHandler_30006_10(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1)) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            SceneManager.changeScene(SceneType.LOBBY, 360);
        }
    }
}
}
