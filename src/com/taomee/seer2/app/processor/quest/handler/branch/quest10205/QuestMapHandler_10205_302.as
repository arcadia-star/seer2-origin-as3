package com.taomee.seer2.app.processor.quest.handler.branch.quest10205 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10194.CandlePelayHandler;

public class QuestMapHandler_10205_302 extends CandlePelayHandler {


    public function QuestMapHandler_10205_302(param1:QuestProcessor) {
        super(param1);
        _questIndex = 9;
        _x = 569;
        _y = 238;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(547, 61);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
