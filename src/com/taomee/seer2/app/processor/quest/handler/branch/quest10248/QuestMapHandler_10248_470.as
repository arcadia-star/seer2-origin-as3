package com.taomee.seer2.app.processor.quest.handler.branch.quest10248 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;

public class QuestMapHandler_10248_470 extends CandlePelayHandler {


    public function QuestMapHandler_10248_470(param1:QuestProcessor) {
        super(param1);
        _questIndex = 5;
        _y = 204;
        _x = 0;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(122, 360);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
