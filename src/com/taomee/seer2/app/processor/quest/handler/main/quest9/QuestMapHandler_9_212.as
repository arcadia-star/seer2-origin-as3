package com.taomee.seer2.app.processor.quest.handler.main.quest9 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;

public class QuestMapHandler_9_212 extends QuestMapHandler {


    public function QuestMapHandler_9_212(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (Boolean(_quest.isStepCompete(1)) && !_quest.isStepCompete(2)) {
            _processor.showMouseHintAt(40, 470);
        }
        if (Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(4)) {
            _processor.showMouseHintAt(180, 280);
        }
        if (Boolean(_quest.isStepCompete(5)) && !_quest.isStepCompete(6)) {
            _processor.showMouseHintAt(40, 470);
        }
    }
}
}
