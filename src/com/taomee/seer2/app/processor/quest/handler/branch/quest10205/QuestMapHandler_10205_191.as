package com.taomee.seer2.app.processor.quest.handler.branch.quest10205 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10194.CandlePelayHandler;

public class QuestMapHandler_10205_191 extends CandlePelayHandler {


    public function QuestMapHandler_10205_191(param1:QuestProcessor) {
        super(param1);
        _questIndex = 7;
        _x = 503;
        _y = 225;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(480, 52);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
