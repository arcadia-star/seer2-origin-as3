package com.taomee.seer2.app.processor.quest.handler.main.quest4 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;

public class QuestMapHandler_4_151 extends QuestMapHandler {


    public function QuestMapHandler_4_151(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.isStepCompete(4)) {
            if (!_quest.isStepCompete(5)) {
                this.processStep5();
            } else if (!_quest.isStepCompete(6)) {
                this.processStep6();
            }
        }
    }

    private function processStep5():void {
        _processor.showMouseHintAt(574, 520);
    }

    private function processStep6():void {
        _processor.showMouseHintAt(450, 290);
    }
}
}
