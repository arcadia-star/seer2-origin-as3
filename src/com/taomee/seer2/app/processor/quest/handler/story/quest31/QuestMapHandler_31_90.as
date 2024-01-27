package com.taomee.seer2.app.processor.quest.handler.story.quest31 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;

public class QuestMapHandler_31_90 extends QuestMapHandler {


    public function QuestMapHandler_31_90(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.isStepCompletable(1)) {
            _processor.showMouseHintAt(640, 340);
        }
    }
}
}
