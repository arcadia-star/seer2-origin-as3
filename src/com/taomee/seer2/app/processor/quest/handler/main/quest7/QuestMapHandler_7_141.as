package com.taomee.seer2.app.processor.quest.handler.main.quest7 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.utils.NpcUtil;

public class QuestMapHandler_7_141 extends QuestMapHandler_7_Base {


    public function QuestMapHandler_7_141(param1:QuestProcessor) {
        super(param1);
        _flagIndex = 3;
    }

    override protected function showSeerDialog():void {
        DialogPanel.showForSimple(NpcUtil.getSeerNpcId(), "我", [[0, "小海马乖乖，来来来……走了哦！跟进哦！"]], "海马保姆……");
    }
}
}
