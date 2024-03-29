package com.taomee.seer2.app.processor.quest.handler.main.quest5 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;

public class QuestMapHandler_5_132 extends QuestMapHandler {


    public function QuestMapHandler_5_132(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(4)) {
            _processor.showMouseHintAt(200, 180);
        }
    }

    override public function processMapDispose():void {
    }
}
}
