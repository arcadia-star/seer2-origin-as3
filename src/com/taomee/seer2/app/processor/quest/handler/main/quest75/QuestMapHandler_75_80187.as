package com.taomee.seer2.app.processor.quest.handler.main.quest75 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class QuestMapHandler_75_80187 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    public function QuestMapHandler_75_80187(param1:QuestProcessor) {
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        ActorManager.hideActor();
        MobileManager.hideMoileVec(MobileType.NPC);
        if (!QuestManager.isAccepted(questID)) {
            QuestManager.accept(questID);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccepted);
        }
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep1();
        }
        if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onAccepted(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep1();
        }
        if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        this._mc1 = null;
        this._mc2 = null;
        this._mc3 = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 230);
    }

    private function initStep1():void {
        this._mc1 = _processor.resLib.getMovieClip("Mc75_0");
        _map.content.addChild(this._mc1);
        this._mc1.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
            NpcDialog.show(36, "玛妈", [[2, "不好了！大火蔓延到整个氏族了！"]], ["火幻氏族居然会着火？"], [function ():void {
                NpcDialog.show(32, "洛克", [[4, " 可恶的萨伦！看来对他们不用客气了！"]], ["恩！给他们点颜色看看！"], [function ():void {
                    NpcDialog.show(31, "巴尔卡", [[0, "快走！一起守护火幻氏族！"]], ["行动起来！"], [function ():void {
                        DisplayObjectUtil.removeFromParent(_mc1);
                        QuestManager.completeStep(questID, 1);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
                    }]);
                }]);
            }]);
        }, true);
    }
}
}
