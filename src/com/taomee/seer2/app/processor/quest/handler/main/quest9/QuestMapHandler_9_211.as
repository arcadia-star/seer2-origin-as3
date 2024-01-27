package com.taomee.seer2.app.processor.quest.handler.main.quest9 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;

public class QuestMapHandler_9_211 extends QuestMapHandler {


    public function QuestMapHandler_9_211(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (Boolean(_quest.isStepCompete(1)) && !_quest.isStepCompete(2)) {
            _processor.showMouseHintAt(173, 490);
        }
        if (Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(4)) {
            _processor.showMouseHintAt(887, 370);
        }
        if (Boolean(_quest.isStepCompete(5)) && !_quest.isStepCompete(6)) {
            _processor.showMouseHintAt(173, 490);
        }
    }
}
}
