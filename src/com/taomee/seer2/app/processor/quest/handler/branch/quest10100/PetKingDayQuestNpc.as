package com.taomee.seer2.app.processor.quest.handler.branch.quest10100 {
import com.taomee.seer2.app.config.QuestConfig;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class PetKingDayQuestNpc {


    private var npc:Mobile;

    private var npcID:int;

    private var npcDef:NpcDefinition;

    private var questName:String;

    private var questId:int;

    public function PetKingDayQuestNpc(param1:int) {
        super();
        this.npcID = param1;
        this.init();
    }

    private function init():void {
        this.npc = MobileManager.getMobile(this.npcID, MobileType.NPC);
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
        ServerBufferManager.getServerBuffer(ServerBufferType.PET_KING_DAY, this.getBuffer);
    }

    private function onNpc(param1:NpcEvent):void {
        if (param1.npcDefinition.id == this.npcID) {
            this.npcDef = param1.npcDefinition;
            if (QuestManager.isComplete(this.questId)) {
                this.npcDef.removeFunctionalityUnit("争霸赛每日竞技项目");
            }
        } else {
            this.npcDef = null;
        }
    }

    public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        if (this.npc) {
            this.npc.removeOverHeadMark();
        }
    }

    private function getBuffer(param1:ServerBuffer):void {
        var _loc3_:int = 0;
        var _loc2_:int = param1.readDataAtPostion(0);
        if (_loc2_ == 0) {
            _loc3_ = Math.random() * 14;
            this.questId = 10100 + _loc3_;
            ServerBufferManager.updateServerBuffer(ServerBufferType.PET_KING_DAY, 0, _loc3_ + 1);
        } else {
            this.questId = 10099 + _loc2_;
        }
        this.questName = QuestConfig.getQuestDefinition(this.questId).name;
        if (!QuestManager.isComplete(this.questId)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        }
    }

    private function onUnit(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (event.content.params == "petkingday") {
            if (!QuestManager.isAccepted(this.questId) && !QuestManager.isComplete(this.questId)) {
                NpcDialog.show(this.npcID, this.npcDef.name, [[0, "今天的目标是：" + this.questName + "，加油吧！"]], ["没问题！"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                    QuestManager.accept(questId);
                }]);
            } else {
                if (!QuestManager.isStepComplete(this.questId, 1)) {
                    NpcDialog.show(this.npcID, this.npcDef.name, [[0, "你还没有完成今天的竞技目标！赶快去" + this.questName + "吧！"]], ["马上去"]);
                }
                if (QuestManager.isStepComplete(this.questId, 1) && !QuestManager.isComplete(this.questId)) {
                    NpcDialog.show(this.npcID, this.npcDef.name, [[0, "好样的！明天再接再厉！"]], ["好的"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                        QuestManager.completeStep(questId, 2);
                    }]);
                }
            }
        }
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId >= 10100 && param1.questId <= 10113) {
            this.npcDef.removeFunctionalityUnit("争霸赛每日竞技项目");
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
    }
}
}
