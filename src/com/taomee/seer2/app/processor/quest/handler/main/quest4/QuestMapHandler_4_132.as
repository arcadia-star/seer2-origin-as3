package com.taomee.seer2.app.processor.quest.handler.main.quest4 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;

public class QuestMapHandler_4_132 extends QuestMapHandler {


    public function QuestMapHandler_4_132(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.isStepCompete(6)) {
            if (!_quest.isStepCompete(7)) {
                this.processStep7();
            }
        }
    }

    private function processStep7():void {
        _processor.showMouseHintAt(180, 250);
    }
}
}
