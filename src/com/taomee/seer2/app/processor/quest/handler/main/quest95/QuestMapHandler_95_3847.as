package com.taomee.seer2.app.processor.quest.handler.main.quest95 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
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

import flash.display.MovieClip;

public class QuestMapHandler_95_3847 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_95_3847(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false) {
            RightToolbarConter.instance.hide();
            if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            } else if (QuestManager.isStepComplete(questID, 2) && !QuestManager.isStepComplete(questID, 3)) {
                this.onStep(null);
            } else if (QuestManager.isStepComplete(questID, 3) && !QuestManager.isStepComplete(questID, 4)) {
                this.onStepFour();
            } else if (QuestManager.isStepComplete(questID, 3) && QuestManager.isStepComplete(questID, 4)) {
                this.onStep4(null);
            }
        }
    }

    private function onStepFour():void {
        this._mc1 = _processor.resLib.getMovieClip("Mc95_0");
        this._mc1.x = 607;
        this._mc1.y = 335;
        _map.front.addChild(this._mc1);
        this._mc1.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_mc1);
            NpcDialog.show(3018, "伊万", [[0, ActorManager.actorInfo.nick + "要跟着主人。不要在阴影中迷失方向。"]], ["放心吧，我可是很有方向感的。"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep4);
                QuestManager.completeStep(questID, 4);
            }]);
        }, true);
    }

    private function onStep4(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep4);
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 934;
        this._mouseHint.y = 240;
        _map.front.addChild(this._mouseHint);
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "95_2") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            QuestManager.completeStep(questID, 2);
        }
    }

    private function onStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        SceneManager.changeScene(SceneType.LOBBY, 10);
    }

    override public function processMapDispose():void {
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        super.processMapDispose();
    }
}
}
