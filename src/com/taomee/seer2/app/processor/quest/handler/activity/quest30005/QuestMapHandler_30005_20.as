package com.taomee.seer2.app.processor.quest.handler.activity.quest30005 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30005_20 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_30005_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.loadBomb();
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.loadQuestion();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isComplete(_quest.id) == false) {
            ActorManager.showRemoteActor = false;
        }
    }

    private function loadBomb():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onBombHandler);
    }

    private function onBombHandler(param1:MouseEvent):void {
        var mc:MovieClip;
        var event:MouseEvent = param1;
        this._mc_0.removeEventListener(MouseEvent.CLICK, this.onBombHandler);
        DisplayUtil.removeForParent(this._mc_0);
        MobileManager.getMobile(2, MobileType.NPC).visible = false;
        this._mc_0 = _processor.resLib.getMovieClip("mc_1");
        _map.front.addChild(this._mc_0);
        mc = this._mc_0.getChildAt(0) as MovieClip;
        MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
            MobileManager.getMobile(2, MobileType.NPC).visible = true;
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(_quest.id);
        }, true);
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        this.loadQuestion();
    }

    private function loadQuestion():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "30005_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            if (this._mc_0) {
                DisplayUtil.removeForParent(this._mc_0);
            }
            this._mc_0 = _processor.resLib.getMovieClip("mc_3");
            _map.content.addChild(this._mc_0);
            this._mc_0.buttonMode = true;
            this._mc_0.addEventListener(MouseEvent.CLICK, this.onSeerTalk);
        }
    }

    private function onSeerTalk(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc_0.removeEventListener(MouseEvent.CLICK, this.onSeerTalk);
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "冰……难道他们去冰沁氏族了？事不宜迟！快前冰沁氏族！"]], ["（前往冰沁氏族）"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Handler);
            QuestManager.completeStep(_quest.id, 1);
        }]);
    }

    private function onStep1Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Handler);
        SceneManager.changeScene(SceneType.LOBBY, 540);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Handler);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
    }
}
}
