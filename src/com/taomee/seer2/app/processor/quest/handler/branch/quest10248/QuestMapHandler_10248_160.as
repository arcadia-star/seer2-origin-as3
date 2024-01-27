package com.taomee.seer2.app.processor.quest.handler.branch.quest10248 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;

public class QuestMapHandler_10248_160 extends CandlePelayHandler {


    public function QuestMapHandler_10248_160(param1:QuestProcessor) {
        super(param1);
        _questIndex = 1;
        _y = 193;
        _x = 527;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(647, 355);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
