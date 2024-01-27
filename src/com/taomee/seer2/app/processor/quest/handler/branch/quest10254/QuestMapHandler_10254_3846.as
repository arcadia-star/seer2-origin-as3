package com.taomee.seer2.app.processor.quest.handler.branch.quest10254 {
import com.greensock.TweenNano;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10254_3846 extends QuestMapHandler {


    public function QuestMapHandler_10254_3846(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10254) && QuestManager.isComplete(10254) == false) {
            if (QuestManager.isStepComplete(10254, 1) && QuestManager.isStepComplete(10254, 2) == false) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            }
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "10254_2") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onCompleted);
            QuestManager.completeStep(questID, 2);
        }
    }

    private function onCompleted(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        if (event.questId == 10254) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleted);
            SceneManager.changeScene(SceneType.LOBBY, 70);
            TweenNano.delayedCall(1, function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("YuanHunBeastPanel"), "", "3");
            });
        }
    }
}
}
