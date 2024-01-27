package com.taomee.seer2.app.processor.quest.handler.branch.quest10024 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10024_141 extends QuestMapHandler {


    private var _npc:MovieClip;

    private var _npc2:MovieClip;

    public function QuestMapHandler_10024_141(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        var _loc1_:Quest = null;
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.getQuest(_quest.id).status == QuestStatus.IN_PROGRESS) {
            this.initNpc();
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.alert();
            }
            return;
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            _loc1_ = QuestManager.getQuest(_quest.id);
            if (_loc1_.getStepData(1, 0) < 5) {
                this.initNpc();
            } else {
                this.initNpc2();
            }
        }
    }

    private function initNpc():void {
        this._npc = _processor.resLib.getMovieClip("npc");
        _map.front.addChild(this._npc);
        this._npc.play();
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function initNpc2():void {
        this._npc2 = _processor.resLib.getMovieClip("npc2");
        _map.front.addChild(this._npc2);
        this._npc2.gotoAndStop(1);
        this._npc2.buttonMode = true;
        this._npc2.addEventListener(MouseEvent.CLICK, this.onClick2);
    }

    private function onClick(param1:MouseEvent):void {
        NpcDialog.show(201, "布鲁托", [[1, "神啊神啊！~~~~赐给我5根木条吧！有了它们我就能做板凳了！我就不用坐在小树根头上咯！"]], ["（打小树根收集5根木条）"]);
    }

    private function alert():void {
        var _loc2_:Quest = null;
        var _loc3_:int = 0;
        var _loc1_:int = int(Math.random() * 100);
        if (_loc1_ >= 0) {
            _loc2_ = QuestManager.getQuest(_quest.id);
            _loc3_ = int(_loc2_.getStepData(1, 0));
            _loc3_++;
            if (_loc3_ >= 5) {
                _loc2_.setStepData(1, 0, _loc3_);
                QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep1);
                QuestManager.setStepBufferServer(_quest.id, 1);
            } else {
                _loc2_.setStepData(1, 0, _loc3_);
                QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep2);
                QuestManager.setStepBufferServer(_quest.id, 1);
            }
        }
    }

    private function onUpdateStepBufferStep1(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep1);
        ServerMessager.addMessage("已收集完成");
        DisplayUtil.removeForParent(this._npc);
        this.initNpc2();
    }

    private function onUpdateStepBufferStep2(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep2);
        ServerMessager.addMessage("还差" + (5 - _quest.getStepData(1, 0)) + "根木条");
    }

    private function onClick2(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        MovieClipUtil.playMc(this._npc2, 2, this._npc2.totalFrames, function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            QuestManager.completeStep(_quest.id, 1);
            DisplayUtil.removeForParent(_npc2);
        }, true);
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (QuestManager.isComplete(10024) && QuestManager.isComplete(10025) && QuestManager.isComplete(10026)) {
            QuestManager.accept(10027);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep1);
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep2);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        DisplayUtil.removeForParent(this._npc);
        DisplayUtil.removeForParent(this._npc2);
        this._npc = null;
        this._npc2 = null;
    }
}
}
