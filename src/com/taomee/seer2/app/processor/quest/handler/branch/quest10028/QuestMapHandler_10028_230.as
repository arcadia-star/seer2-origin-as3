package com.taomee.seer2.app.processor.quest.handler.branch.quest10028 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_10028_230 extends QuestMapHandler {


    public function QuestMapHandler_10028_230(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1)) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var _loc2_:String = param1.params;
        if (_loc2_ == "10028_1") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
            QuestManager.completeStep(_quest.id, 2);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (QuestManager.isComplete(10028) && QuestManager.isComplete(10029) && QuestManager.isComplete(10030) && QuestManager.isComplete(10031)) {
            QuestManager.accept(10032);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
    }
}
}
