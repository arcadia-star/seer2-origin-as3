package com.taomee.seer2.app.processor.quest.handler.story.quest63 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_63_10 extends QuestMapHandler {


    public function QuestMapHandler_63_10(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep1);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "63_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
            QuestManager.accept(_quest.id);
        }
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 20);
    }

    private function onStep1(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "63_3") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep1);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onCompleteHandler);
            QuestManager.completeStep(_quest.id, 5);
        }
    }

    private function onCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteHandler);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteHandler);
    }
}
}
