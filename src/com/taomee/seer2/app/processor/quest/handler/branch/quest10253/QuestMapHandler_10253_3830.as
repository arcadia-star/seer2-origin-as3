package com.taomee.seer2.app.processor.quest.handler.branch.quest10253 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10253_3830 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_10253_3830(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DisplayObjectUtil.removeFromParent(this._mouseHint);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(10253)) {
            this.initAccept();
        }
        if (QuestManager.isAccepted(10253) && !QuestManager.isComplete(10253) && QuestManager.isStepComplete(10253, 1) == false) {
            this.initStep1();
        } else if (QuestManager.isStepComplete(10253, 1) == true && QuestManager.isStepComplete(10253, 2) == false) {
            this.onStep(null);
        }
    }

    private function initAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 10253) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initStep1();
        }
    }

    private function initStep1():void {
        NpcDialog.show(1032, "梵拉", [[0, "请各位跟我来，原魂兽的召唤仪式必须在圣地能量之源进行。"]], ["我是外人能不能进圣地？"], [function ():void {
            NpcDialog.show(1017, "瓦利大叔", [[0, ActorManager.actorInfo.nick + ",这是我族历史性的的一刻，作为我们的好伙伴，你功不可没！与我们一同进入能量之源吧！"]], ["我们走！！！"], [function ():void {
                _mc1 = _processor.resLib.getMovieClip("Mc10253_0");
                _mc1.x = 576;
                _mc1.y = 321;
                _map.front.addChild(_mc1);
                _mc1.gotoAndStop(1);
                MovieClipUtil.playMc(_mc1, 1, _mc1.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_mc1);
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                    QuestManager.completeStep(questID, 1);
                }, true);
            }]);
        }]);
    }

    private function onStep(param1:QuestEvent):void {
        if (param1 == null || param1.questId == 10253 && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = 157;
            this._mouseHint.y = 520;
            _map.front.addChild(this._mouseHint);
        }
    }
}
}
