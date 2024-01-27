package com.taomee.seer2.app.processor.quest.handler.story.quest15 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_15_510 extends QuestMapHandler {


    private var _mc_3:MovieClip;

    private var _mc_4:MovieClip;

    public function QuestMapHandler_15_510(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.showMC3();
        }
    }

    private function showMC3():void {
        this._mc_3 = _processor.resLib.getMovieClip("mc_3");
        this._mc_3.x = 284;
        this._mc_3.y = 382;
        _map.front.addChild(this._mc_3);
        this._mc_3.buttonMode = true;
        this._mc_3.addEventListener(MouseEvent.CLICK, this.onMC3Click);
        this._mc_4 = _processor.resLib.getMovieClip("mc_4");
        _map.front.addChild(this._mc_4);
        this._mc_4.gotoAndStop(1);
    }

    private function onMC3Click(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc_3.removeEventListener(MouseEvent.CLICK, this.onMC3Click);
        NpcDialog.show(440, "暗伊特", [[0, "嘻嘻，真是个粗心的小鬼！还要跟着哥哥我好好锻炼才行。"]], ["去地月氏族主城"], [function ():void {
            ServerMessager.addMessage("获得5颗碎钻");
            DisplayUtil.removeForParent(_mc_3);
            _mc_3 = null;
            MovieClipUtil.playMc(_mc_4, 2, _mc_4.totalFrames, function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onQuestStep);
                QuestManager.completeStep(_quest.id, 3);
            }, true);
        }]);
    }

    private function onQuestStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        this.addMouseClickHint();
    }

    private function addMouseClickHint():void {
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isCompletable(_quest.id)) {
            _processor.showMouseHintAt(240, 420);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        _processor.hideMouseClickHint();
        DisplayUtil.removeForParent(this._mc_3);
        this._mc_3 = null;
        DisplayUtil.removeForParent(this._mc_4);
        this._mc_4 = null;
    }
}
}
