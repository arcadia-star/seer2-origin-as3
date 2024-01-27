package com.taomee.seer2.app.processor.quest.handler.story.quest17 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;

public class QuestMapHandler_17_125 extends QuestMapHandler {


    public function QuestMapHandler_17_125(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) == false && QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        if (param1.params == "17_0") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.accept(_quest.id);
        }
        if (param1.params == "17_1") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.completeStep(_quest.id, 2);
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
    }
}
}
