package com.taomee.seer2.app.processor.quest.handler.main.quest96 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
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
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_96_3848 extends QuestMapHandler {


    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_96_3848(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(questID)) {
            RightToolbarConter.instance.hide();
            this.initAccept();
        }
        if (QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false) {
            RightToolbarConter.instance.hide();
            if (QuestManager.isStepComplete(questID, 1) == false) {
                this.initStep1();
            } else if (QuestManager.isStepComplete(questID, 2) == false) {
                SceneManager.changeScene(SceneType.LOBBY, 3847);
            } else if (QuestManager.isStepComplete(questID, 2) && !QuestManager.isStepComplete(questID, 3)) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            }
        } else if (QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
        if (DialogPanelEventData(evt.content).params == "96_3") {
            QuestManager.completeStep(questID, 3);
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("searchDarkCode/searchDarkCode1"), function callBack():void {
                onComplete(null);
            }, true, true, 2, true);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function initAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 96) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initStep1();
        }
    }

    private function initStep1():void {
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 154;
        this._mouseHint.y = 438;
        _map.front.addChild(this._mouseHint);
    }

    override public function processMapDispose():void {
        if (this._mouseHint) {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
            this._mouseHint = null;
        }
        super.processMapDispose();
        RightToolbarConter.instance.show();
    }
}
}
