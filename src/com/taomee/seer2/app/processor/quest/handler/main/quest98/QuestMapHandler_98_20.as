package com.taomee.seer2.app.processor.quest.handler.main.quest98 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_98_20 extends QuestMapHandler {


    public function QuestMapHandler_98_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) == false) {
            RightToolbarConter.instance.hide();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
        } else if (QuestManager.isAccepted(questID) && QuestManager.completeStep(questID, 1) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if (DialogPanelEventData(evt.content).params == "98_0") {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("DarkDefender0"), function callBack():void {
                QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                QuestManager.accept(questID);
            }, true, true, 2, true);
        } else if (DialogPanelEventData(evt.content).params == "98_1") {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.initStep2);
            QuestManager.completeStep(questID, 1);
        }
    }

    private function initStep2(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.initStep2);
        SceneManager.changeScene(SceneType.LOBBY, 3848);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 98) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        RightToolbarConter.instance.show();
    }
}
}
