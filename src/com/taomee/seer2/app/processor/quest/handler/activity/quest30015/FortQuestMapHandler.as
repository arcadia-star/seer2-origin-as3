package com.taomee.seer2.app.processor.quest.handler.activity.quest30015 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.gameRule.door.BaseDoor;
import com.taomee.seer2.app.gameRule.door.support.IUpDoorSupport;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

public class FortQuestMapHandler extends QuestMapHandler {


    protected var npcId:int;

    protected var npc:Mobile;

    protected var npcName:String;

    protected var mark:AcceptableMark;

    protected var _supportInstance:IUpDoorSupport;

    protected var battleScene:int;

    protected var door:BaseDoor;

    protected var npcTalkId:String;

    protected var questParams:String;

    protected var questId:int;

    private var stepId:int;

    private var npcDef:NpcDefinition;

    public function FortQuestMapHandler(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeQuest);
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.npc = MobileManager.getMobile(this.npcId, MobileType.NPC);
        this.npc.buttonMode = true;
        if (!QuestManager.isComplete(_quest.id)) {
            this.addNpcMark();
            if (!QuestManager.isAccepted(_quest.id)) {
                this.questParams = _quest.id.toString() + "_0";
            }
            if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
                this.questParams = _quest.id.toString() + "_1";
            }
            if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
                this.questParams = _quest.id.toString() + "_2";
            }
            if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
                this.questParams = _quest.id.toString() + "_3";
            }
            if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isStepComplete(_quest.id, 4)) {
                this.questParams = _quest.id.toString() + "_4";
            }
            NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
            return;
        }
    }

    protected function onActorArriveShow(param1:NpcEvent):void {
        var _loc2_:XML = null;
        if (param1.npcDefinition.id == this.npcId) {
            this.npcDef = param1.npcDefinition;
            param1.npcDefinition.resetFunctionalityData();
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
            _loc2_ = <node type="quest"/>;
            _loc2_.@name = _quest.name;
            _loc2_.@params = this.questParams;
            param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 1);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        }
    }

    protected function onUnit(param1:DialogPanelEvent):void {
        if (param1.content.params == this.questParams) {
            switch (this.questParams) {
                case _quest.id.toString() + "_0":
                    this.showAcceptDia();
                    break;
                case _quest.id.toString() + "_1":
                    this.toStep1Dia();
                    break;
                case _quest.id.toString() + "_2":
                    this.toStep2Dia();
                    break;
                case _quest.id.toString() + "_3":
                    this.toStep3Dia();
                    break;
                case _quest.id.toString() + "_4":
                    this.toStep4Dia();
            }
        }
    }

    protected function toStep4Dia():void {
        NpcDialog.show(this.npcId, this.npcName, [[0, "干得不错哦，来这个给你的奖励。"]], ["领取奖励"], [function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, completeQuest);
            stepId = 4;
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, onActorArriveShow);
            QuestManager.completeStep(questId, 4);
        }]);
    }

    protected function toStep3Dia():void {
    }

    protected function showAcceptDia():void {
    }

    protected function toStep1Dia():void {
    }

    protected function toStep2Dia():void {
        NpcDialog.show(this.npcId, this.npcName, [[0, "干得不错哦，来这个给你的奖励。"]], ["领取奖励"], [function ():void {
            stepId = 2;
            questParams = _quest.id.toString() + "_3";
            NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, onActorArriveShow);
            if (questId == 30019) {
                QuestManager.addEventListener(QuestEvent.COMPLETE, completeQuest);
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30019_0"), function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, completeQuest);
                    QuestManager.completeStep(30019, 2);
                });
            } else {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep);
                QuestManager.completeStep(questId, 2);
            }
        }]);
    }

    private function completeQuest(param1:QuestEvent):void {
        if (param1.questId == this.questId) {
            DisplayObjectUtil.removeFromParent(this.mark);
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeQuest);
            if (this.npcDef) {
                this.npcDef.resetFunctionalityData();
            }
            this.processMapDispose();
        }
    }

    protected function showNextQuestDia():void {
    }

    private function completeStep(param1:QuestEvent):void {
        if (param1.questId == this.questId && param1.stepId == this.stepId) {
            if (this.stepId == 2) {
                this.toStep3Dia();
            }
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
        }
    }

    protected function onAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this._supportInstance.reset();
            this._supportInstance.supportInfo.currentDoorLevel = 1;
            this._supportInstance.supportInfo.reset = true;
            SceneManager.changeScene(SceneType.LOBBY, this.battleScene);
        }
    }

    protected function addNpcMark():void {
        this.mark = new AcceptableMark();
        this.mark.y = -120;
        this.npc.addChild(this.mark);
    }
}
}
