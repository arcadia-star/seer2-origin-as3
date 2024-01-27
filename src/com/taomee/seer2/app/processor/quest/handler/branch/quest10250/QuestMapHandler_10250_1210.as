package com.taomee.seer2.app.processor.quest.handler.branch.quest10250 {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10250_1210 extends QuestMapHandler {


    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_10250_1210(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isComplete(10250) == false) {
            if (QuestManager.isStepComplete(10250, 2) && QuestManager.isStepComplete(10250, 3) == false) {
                QuestManager.completeStep(10250, 3);
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            }
            if (QuestManager.isStepComplete(10250, 4) && QuestManager.isStepComplete(10250, 5) == false) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            }
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "10250_5") {
            RightToolbarConter.instance.hide();
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = 1043;
            this._mouseHint.y = 120;
            _map.front.addChild(this._mouseHint);
            (_map.content["qdwq"]["mirrorMc"] as MovieClip).addEventListener(MouseEvent.CLICK, this.onMirror);
            (_map.content["qdwq"]["mirrorMc"] as MovieClip).buttonMode = true;
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1 == null || param1.questId == 10250 && param1.stepId == 3) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = 722;
            this._mouseHint.y = 553;
            _map.front.addChild(this._mouseHint);
        }
    }

    private function onMirror(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(400, "赛尔", [[0, "魔镜有一种说不出的感觉，似乎它是一道门，里面有另一个世界存在着。 "]], ["准备好就进去看一下"], [function ():void {
            DisplayObjectUtil.removeFromParent(_mouseHint);
            RightToolbarConter.instance.show();
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
            QuestManager.completeStep(questID, 5);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 10250) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
            RightToolbarConter.instance.show();
            ModuleManager.toggleModule(URLUtil.getAppModule("ShiHunBeastPanel"), "", "2");
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        RightToolbarConter.instance.show();
    }
}
}
