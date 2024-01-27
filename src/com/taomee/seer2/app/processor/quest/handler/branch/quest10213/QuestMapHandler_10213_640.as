package com.taomee.seer2.app.processor.quest.handler.branch.quest10213 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10142.CandlePelayHandler;

public class QuestMapHandler_10213_640 extends CandlePelayHandler {


    public function QuestMapHandler_10213_640(param1:QuestProcessor) {
        super(param1);
        _questIndex = 3;
        _y = 104;
        _x = 308;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(400, 150);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
