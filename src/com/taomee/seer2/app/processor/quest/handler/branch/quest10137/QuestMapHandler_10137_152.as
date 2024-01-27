package com.taomee.seer2.app.processor.quest.handler.branch.quest10137 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10137_152 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_10137_152(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isStepComplete(_quest.id, 7) && QuestManager.isStepComplete(_quest.id, 8) == false) {
            this.addBird();
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "10137_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10137_4"), function ():void {
                QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                QuestManager.accept(_quest.id);
            }, true, false, 2);
        }
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 153);
    }

    private function addBird():void {
        _processor.showMouseHintAt(228, 244);
        this._mc_0 = _processor.resLib.getMovieClip("bird");
        _map.content.addChild(this._mc_0);
        this._mc_0["birds"].buttonMode = true;
        this._mc_0["birds"].addEventListener(MouseEvent.CLICK, this.onPlayFullHandler);
    }

    private function onPlayFullHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10137_3"), function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onStep8Handler);
            QuestManager.completeStep(_quest.id, 8);
        }, true, false, 2);
    }

    private function onStep8Handler(param1:QuestEvent):void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep8Handler);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep8Handler);
    }
}
}
