package com.taomee.seer2.app.processor.quest.handler.story.quest32 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_32_10 extends QuestMapHandler {


    public function QuestMapHandler_32_10(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
        }
        if (QuestManager.isStepComplete(_quest.id, 1) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "32_1") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            QuestManager.completeStep(_quest.id, 1);
        }
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            SceneManager.changeScene(SceneType.LOBBY, 770);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        super.processMapDispose();
    }
}
}
