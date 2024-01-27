package com.taomee.seer2.app.processor.quest.handler.branch.quest10026 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_10026_470 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_10026_470(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var _loc2_:String = param1.params;
        if (_loc2_ == "10026_1") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
            QuestManager.completeStep(_quest.id, 2);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (QuestManager.isComplete(10024) && QuestManager.isComplete(10025) && QuestManager.isComplete(10026)) {
            QuestManager.accept(10027);
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        this._npc = null;
    }
}
}
