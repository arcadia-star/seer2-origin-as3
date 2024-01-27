package com.taomee.seer2.app.processor.quest.handler.branch.quest10197 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10197_320 extends QuestMapHandler {


    public function QuestMapHandler_10197_320(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedToAccept()) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        }
        if (isNeedCompleteStep(2)) {
            DialogPanel.addCloseEventListener(this.onClose);
        }
    }

    private function onClose(param1:DialogCloseEvent):void {
        var event:DialogCloseEvent = param1;
        var params:String = event.params;
        if (params == "playFull") {
            DialogPanel.removeCloseEventListener(this.onClose);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10197_0"), function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                QuestManager.completeStep(10197, 2);
            });
        }
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 10197) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"), "", "3");
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }
}
}
