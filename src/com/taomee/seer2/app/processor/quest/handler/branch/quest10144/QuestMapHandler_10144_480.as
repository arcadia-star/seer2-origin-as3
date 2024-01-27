package com.taomee.seer2.app.processor.quest.handler.branch.quest10144 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10144_480 extends QuestMapHandler {


    private var counterAndShalun:MovieClip;

    private var _counter:MovieClip;

    private var _shalun:MovieClip;

    private var _mark:AcceptableMark;

    public function QuestMapHandler_10144_480(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        ActorManager.showRemoteActor = true;
        MonsterManager.showAllMonster();
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        if (this._counter) {
            this._counter.removeEventListener(MouseEvent.CLICK, this.toPlayFull0);
            this._counter.removeEventListener(MouseEvent.CLICK, this.showCounterDia);
        }
        if (this._shalun) {
            this._shalun.removeEventListener(MouseEvent.CLICK, this.showCounterShalunDia);
        }
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedToAccept() || !isStepComplete(2)) {
            this.createNpc();
        }
        if (isNeedToAccept()) {
            this.initAccept();
        }
        if (isNeedCompleteStep(1)) {
            this.initStep1();
        }
        if (isNeedCompleteStep(2)) {
            this.initStep2();
        }
    }

    private function initAccept():void {
        if (!this._mark) {
            this._mark = new AcceptableMark();
        }
        this._mark.x = 470;
        this._mark.y = 215;
        this.counterAndShalun.addChild(this._mark);
        this._counter.buttonMode = true;
        this._counter.addEventListener(MouseEvent.CLICK, this.toPlayFull0);
    }

    private function toPlayFull0(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10144_0"), function ():void {
            _counter.buttonMode = false;
            _counter.removeEventListener(MouseEvent.CLICK, toPlayFull0);
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(questID);
        });
    }

    private function createNpc():void {
        ActorManager.showRemoteActor = false;
        MonsterManager.hideAllMonster();
        this.counterAndShalun = _processor.resLib.getMovieClip("CounterAndShalun");
        this.counterAndShalun["fire"].mouseEnabled = false;
        this.counterAndShalun["fire"].mouseChildren = false;
        this._counter = this.counterAndShalun["counter"];
        this._shalun = this.counterAndShalun["shalun"];
        _map.content.addChild(this.counterAndShalun);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initStep1();
        }
    }

    private function initStep1():void {
        if (!this._mark) {
            this._mark = new AcceptableMark();
        }
        this._mark.x = 470;
        this._mark.y = 215;
        this.counterAndShalun.addChild(this._mark);
        this._counter.buttonMode = true;
        this._counter.addEventListener(MouseEvent.CLICK, this.showCounterDia);
    }

    private function showCounterDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(178, "康特", [[0, "哈哈哈！我是圣诞老爹的胖精灵，算算到现在我已经去过999个星球旅行过，见过9999种不同的圣诞礼物呢……"]], [], [function ():void {
            NpcDialog.show(178, "康特", [[0, "你们这些小鬼想不想听听康特的冒险故事呀？"]], [], [function ():void {
                NpcDialog.show(178, "康特", [[0, "好久没出雪人村了，正好今天我心情好，你们这些小鬼有福了！那我就给你们讲讲我见过最美的地方，也是我现在的家乡——雪人村"]], [], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10144_1"), function ():void {
                        _counter.buttonMode = false;
                        _counter.removeEventListener(MouseEvent.CLICK, showCounterDia);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                        QuestManager.completeStep(questID, 1);
                    });
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            if (param1.stepId == 1) {
                this.initStep2();
            } else if (param1.stepId == 2) {
                SceneManager.changeScene(SceneType.LOBBY, 10108);
            }
        }
    }

    private function initStep2():void {
        if (!this._mark) {
            this._mark = new AcceptableMark();
        }
        this._mark.x = 550;
        this._mark.y = 330;
        this.counterAndShalun.addChild(this._mark);
        this._shalun.buttonMode = true;
        this._shalun.addEventListener(MouseEvent.CLICK, this.showCounterShalunDia);
    }

    private function showCounterShalunDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10144_2"), function ():void {
            _shalun.buttonMode = false;
            _shalun.removeEventListener(MouseEvent.CLICK, showCounterDia);
            NpcDialog.show(178, "康特", [[0, "那我们现在就出发吧！"]], [], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                QuestManager.completeStep(questID, 2);
            }]);
        }, false, false, 1, false);
    }
}
}
