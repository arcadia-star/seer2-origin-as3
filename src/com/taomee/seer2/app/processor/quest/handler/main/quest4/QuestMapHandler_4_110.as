package com.taomee.seer2.app.processor.quest.handler.main.quest4 {
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;

public class QuestMapHandler_4_110 extends QuestMapHandler {


    private var _stepAnimation:MovieClip;

    private var _resultInfo:FightResultInfo;

    public function QuestMapHandler_4_110(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.status == QuestStatus.ACCEPTABLE) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        } else if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (!_quest.isStepCompete(1)) {
                this.processStep1();
            } else if (!_quest.isStepCompete(2)) {
                this.processStep2();
            } else if (!_quest.isStepCompete(3)) {
                this.processStep3();
            }
            if (Boolean(_quest.isStepCompete(9)) && !_quest.isStepCompete(10)) {
                this.processStep10();
                PetInfoManager.addEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
            }
        }
    }

    private function onQuestAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            this.processStep1();
        }
    }

    private function processStep1():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if (DialogPanelEventData(evt.content).params == "4_1") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            MovieClipUtil.playHahaTalk(URLUtil.getQuestAnimation("4/quest4Animation1"), 2, [770, 475], function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete1);
                QuestManager.completeStep(_quest.id, 1);
            });
        }
    }

    private function onStepComplete1(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete1);
            this.processStep2();
        }
    }

    private function processStep2():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete2);
    }

    private function onStepComplete2(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete2);
            this.processStep3();
        }
    }

    private function processStep3():void {
        DialogPanel.showForSimple(16, "神目酋长", [[0, "勇敢的赛尔，请您保护我的精灵特鲁伊！"]], "尊敬的酋长，我很乐意！", function ():void {
            hideTeruy();
            _stepAnimation = _map.content["quest_4"];
            MovieClipUtil.playMc(_stepAnimation, 2, _stepAnimation.totalFrames, function ():void {
                _stepAnimation.gotoAndStop(1);
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete3);
                QuestManager.completeStep(_quest.id, 3);
            }, true);
        });
    }

    private function onStepComplete3(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete3);
            _processor.showMouseHintAt(-34, 500);
        }
    }

    private function processStep10():void {
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        QuestManager.completeStep(_quest.id, 10);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        ModuleManager.addEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }

    private function onPetLevelUp(param1:PetInfoEvent):void {
        this._resultInfo = param1.content.resultInfo;
    }

    private function teacherPlayerHandler(param1:Event = null):void {
        ModuleManager.removeEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
    }

    private function hideTeruy():void {
        var _loc1_:Mobile = MobileManager.getMobile(17, MobileType.NPC);
        _loc1_.visible = false;
    }

    override public function processMapDispose():void {
        PetInfoManager.removeEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
        ModuleManager.removeEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        super.processMapDispose();
    }
}
}
