package com.taomee.seer2.app.processor.quest.handler.branch.quest10248 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10248_540 extends CandlePelayHandler {


    public function QuestMapHandler_10248_540(param1:QuestProcessor) {
        super(param1);
        _questIndex = 6;
        _y = 150;
        _x = 668;
    }

    override protected function showGuide():void {
        _processor.showMouseHintAt(790, 307);
    }

    override protected function getAward():void {
        this.playFullMovie();
    }

    private function playFullMovie():void {
        DisplayUtil.removeForParent(_candleMc);
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
        QuestManager.completeStep(_quest.id, 1);
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        ModuleManager.showAppModule("GetMiKaByRedFlagRewardPanel");
    }
}
}
