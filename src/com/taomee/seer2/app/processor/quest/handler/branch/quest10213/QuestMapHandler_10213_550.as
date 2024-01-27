package com.taomee.seer2.app.processor.quest.handler.branch.quest10213 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10142.CandlePelayHandler;

public class QuestMapHandler_10213_550 extends CandlePelayHandler {


    public function QuestMapHandler_10213_550(param1:QuestProcessor) {
        super(param1);
        _questIndex = 2;
        _y = 200;
        _x = 628;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(680, 253);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
