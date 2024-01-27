package com.taomee.seer2.app.processor.quest.handler.story.quest25 {
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_25_5208 extends QuestMapHandler {


    public function QuestMapHandler_25_5208(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 25) {
            this.processMapDispose();
            this.showMessage();
        }
    }

    private function showMessage():void {
        ServerMessager.addMessage("下一步: 前往 <font color=\'#ffcc00\'>地月氏族主城</font> 找 <font color=\'#ffcc00\'>神月老大</font>");
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        super.processMapDispose();
    }
}
}
