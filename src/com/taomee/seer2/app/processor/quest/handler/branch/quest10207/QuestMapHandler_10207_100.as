package com.taomee.seer2.app.processor.quest.handler.branch.quest10207 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10194.TorchRelayHandler;

public class QuestMapHandler_10207_100 extends TorchRelayHandler {


    public function QuestMapHandler_10207_100(param1:QuestProcessor) {
        super(param1);
        _questIndex = 2;
        _y = 316;
        _x = 473;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(460, 150);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
