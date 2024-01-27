package com.taomee.seer2.app.processor.quest.handler.main.quest95 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;

public class QuestMapHandler_95_10 extends QuestMapHandler {


    public function QuestMapHandler_95_10(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false) {
            RightToolbarConter.instance.hide();
            if (QuestManager.isStepComplete(questID, 2) && !QuestManager.isStepComplete(questID, 3)) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            }
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "95_3") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            if (!DateUtil.isInHourScope(12, 14, 0, 0)) {
                return;
            }
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            QuestManager.completeStep(questID, 3);
        }
    }

    private function onStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        SceneManager.changeScene(SceneType.LOBBY, 3847);
    }

    override public function processMapDispose():void {
        RightToolbarConter.instance.show();
        super.processMapDispose();
    }
}
}
