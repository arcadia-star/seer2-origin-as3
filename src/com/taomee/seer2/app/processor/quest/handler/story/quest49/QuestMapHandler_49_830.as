package com.taomee.seer2.app.processor.quest.handler.story.quest49 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_49_830 extends QuestMapHandler {


    public function QuestMapHandler_49_830(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onFirstStepHandler);
        }
    }

    private function onFirstStepHandler(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "49_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onFirstStepHandler);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
            QuestManager.accept(_quest.id);
        }
    }

    private function AcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 840);
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onFirstStepHandler);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
    }
}
}
