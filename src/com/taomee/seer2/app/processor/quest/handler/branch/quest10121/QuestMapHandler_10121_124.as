package com.taomee.seer2.app.processor.quest.handler.branch.quest10121 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;

public class QuestMapHandler_10121_124 extends CandlePelayHandler {


    public function QuestMapHandler_10121_124(param1:QuestProcessor) {
        super(param1);
        _questIndex = 4;
        _y = 316;
        _x = 413;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(392, 139);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
