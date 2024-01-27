package com.taomee.seer2.app.processor.quest.handler.main.quest7 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.utils.NpcUtil;

public class QuestMapHandler_7_152 extends QuestMapHandler_7_Base {


    public function QuestMapHandler_7_152(param1:QuestProcessor) {
        super(param1);
        _flagIndex = 4;
    }

    override protected function showSeerDialog():void {
        DialogPanel.showForSimple(NpcUtil.getSeerNpcId(), "我", [[0, "又气又好笑……这群小家伙真是……"]], "走！我们回家了！");
    }
}
}
