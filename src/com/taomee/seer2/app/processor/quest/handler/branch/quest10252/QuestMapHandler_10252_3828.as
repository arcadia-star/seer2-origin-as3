package com.taomee.seer2.app.processor.quest.handler.branch.quest10252 {
import com.greensock.TweenNano;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10252_3828 extends QuestMapHandler {


    public function QuestMapHandler_10252_3828(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10252) && QuestManager.isComplete(10252) == false) {
            if (QuestManager.isStepComplete(10252, 1) && QuestManager.isStepComplete(10252, 2) == false) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            }
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "10252_2") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onCompleted);
            QuestManager.completeStep(questID, 2);
        }
    }

    private function onCompleted(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        if (event.questId == 10252) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleted);
            MonsterManager.showAllMonster();
            SceneManager.changeScene(SceneType.LOBBY, 70);
            TweenNano.delayedCall(1, function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("YuanHunBeastPanel"), "", "1");
            });
        }
    }
}
}
