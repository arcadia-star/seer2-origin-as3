package com.taomee.seer2.app.processor.quest.handler.main.quest12 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_12_230 extends QuestMapHandler {


    public function QuestMapHandler_12_230(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.addMouseClickHint();
        if (!QuestManager.isStepComplete(_quest.id, 1)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        }
    }

    private function onQuestStep(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            this.addMouseClickHint();
        }
    }

    private function addMouseClickHint():void {
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isCompletable(_quest.id)) {
            _processor.showMouseHintAt(4, 500);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        _processor.hideMouseClickHint();
    }
}
}
