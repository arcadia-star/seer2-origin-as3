package com.taomee.seer2.app.processor.quest.handler.main.quest7 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.utils.NpcUtil;

public class QuestMapHandler_7_131 extends QuestMapHandler_7_Base {


    public function QuestMapHandler_7_131(param1:QuestProcessor) {
        super(param1);
        _flagIndex = 1;
    }

    override protected function showSeerDialog():void {
        DialogPanel.showForSimple(NpcUtil.getSeerNpcId(), "我", [[0, "囧……找不到家人还能玩的这么欢……"]], "快跟我走吧！");
    }
}
}
