package com.taomee.seer2.app.processor.quest.handler.branch.quest10205 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10194.TorchRelayHandler;

public class QuestMapHandler_10205_203 extends TorchRelayHandler {


    public function QuestMapHandler_10205_203(param1:QuestProcessor) {
        super(param1);
        _questIndex = 5;
        _x = 348;
        _y = 332;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(320, 150);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
    }
}
}
