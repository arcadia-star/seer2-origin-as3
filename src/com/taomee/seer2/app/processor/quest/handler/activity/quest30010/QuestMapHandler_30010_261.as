package com.taomee.seer2.app.processor.quest.handler.activity.quest30010 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_30010_261 extends QuestMapHandler {


    private var maliMc1:MovieClip;

    private var maliAndMother:MovieClip;

    private var timerout:uint;

    public function QuestMapHandler_30010_261(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isStepComplete(_quest.id, 4)) {
            MonsterManager.hideAllMonster();
            if (SceneManager.prevSceneType != SceneType.ARENA) {
                this.initStep4();
            } else if (!FightManager.isWinWar()) {
                this.battleResult();
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && !QuestManager.isStepComplete(_quest.id, 5)) {
            this.initStep5();
            MonsterManager.hideAllMonster();
        }
    }

    private function battleResult():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30010_0"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep4);
            QuestManager.completeStep(_quest.id, 4);
        });
    }

    private function completeStep4(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 4) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep4);
            this.initStep5();
        }
    }

    private function initStep5():void {
        this.maliAndMother = _processor.resLib.getMovieClip("maliAndMother");
        this.maliAndMother.buttonMode = true;
        _map.content.addChild(this.maliAndMother);
        this.maliAndMother.addEventListener(MouseEvent.CLICK, this.showMaDia);
    }

    private function showMaDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(119, "玛里+他妈妈", [[0, "恩公！今天如果没有你！我们母子可能命丧于此！多谢你……"]], ["没它我可能也命丧于此"], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30010_1"), function ():void {
                _map.content.removeChild(maliAndMother);
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                QuestManager.completeStep(_quest.id, 5);
            }, false);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 30010) {
            MonsterManager.showAllMonster();
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    private function initStep4():void {
        this.maliMc1 = _processor.resLib.getMovieClip("maliMc1");
        _map.front.addChild(this.maliMc1);
        MovieClipUtil.playMc(this.maliMc1, 1, this.maliMc1.totalFrames, function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "放开他们！有本事冲我来！欺负弱小算什么！"]], ["点击领头的爪牙"], [function ():void {
                FightManager.startFightWithWild(100);
            }]);
        }, true);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep4);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (this.maliAndMother) {
            this.maliAndMother.removeEventListener(MouseEvent.CLICK, this.showMaDia);
        }
        super.processMapDispose();
    }
}
}
