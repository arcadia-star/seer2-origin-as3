package com.taomee.seer2.app.processor.quest.handler.branch.quest10248 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;

public class QuestMapHandler_10248_90 extends CandlePelayHandler {


    public function QuestMapHandler_10248_90(param1:QuestProcessor) {
        super(param1);
        _questIndex = 2;
        _y = 150;
        _x = 10;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(135, 308);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
