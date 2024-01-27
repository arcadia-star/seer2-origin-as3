package com.taomee.seer2.app.processor.quest.handler.branch.quest10191 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;

public class QuestMapHandler_10191_230 extends TorchRelayHandler {


    public function QuestMapHandler_10191_230(param1:QuestProcessor) {
        super(param1);
        _questIndex = 10;
        _x = 545;
        _y = 485;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(530, 300);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
