package com.taomee.seer2.app.processor.quest.handler.branch.quest10195 {
import com.taomee.seer2.app.dialog.NpcDialog;
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

public class QuestMapHandler_10195_5001 extends QuestMapHandler {


    private var light:MovieClip;

    private var book:MovieClip;

    private var arrow:MovieClip;

    public function QuestMapHandler_10195_5001(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.light = _map.content["inte2"];
        this.book = _map.content["book"];
        this.book.visible = false;
        this.book.buttonMode = true;
        this.arrow = _map.content["arrow"];
        this.arrow.stop();
        this.arrow.visible = false;
        if (QuestManager.isAccepted(10195) && !QuestManager.isStepComplete(10195, 1)) {
            this.arrow.visible = true;
            this.arrow.play();
            this.light.addEventListener(MouseEvent.CLICK, this.onLight, false, 1);
        }
    }

    private function onLight(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        this.light.removeEventListener(MouseEvent.CLICK, this.onLight);
        this.light.gotoAndPlay(2);
        this.book.visible = true;
        this.book.addEventListener(MouseEvent.CLICK, this.onBook);
    }

    private function onBook(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        this.book.removeEventListener(MouseEvent.CLICK, this.onBook);
        this.book.visible = false;
        this.arrow.stop();
        this.arrow.visible = false;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10195_0"), function ():void {
            NpcDialog.show(400, "我", [[0, "这上面都写了点啥呀？还是去问问汪总管吧。"]], ["Go Go Go！！！"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                QuestManager.completeStep(10195, 1);
            }]);
        });
    }

    private function onStepComplete(param1:QuestEvent):void {
        if (param1.questId == 10195 && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            SceneManager.changeScene(SceneType.LOBBY, 330);
        }
    }

    override public function processMapDispose():void {
        this.light.removeEventListener(MouseEvent.CLICK, this.onLight);
        this.book.removeEventListener(MouseEvent.CLICK, this.onBook);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        super.processMapDispose();
    }
}
}
