package com.taomee.seer2.app.processor.quest.handler.branch.quest10142 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;

public class QuestMapHandler_10142_640 extends CandlePelayHandler {


    public function QuestMapHandler_10142_640(param1:QuestProcessor) {
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
