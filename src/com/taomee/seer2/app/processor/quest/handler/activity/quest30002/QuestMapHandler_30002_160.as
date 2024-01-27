package com.taomee.seer2.app.processor.quest.handler.activity.quest30002 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_30002_160 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_30002_160(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initQuestStep1();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initQuestStep2();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.initQuestStep3();
        }
    }

    private function initQuestStep1():void {
        DialogPanel.addCloseEventListener(this.onShowAnimation);
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var _loc2_:String = param1.params;
        if (_loc2_ == "30002_1") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            QuestManager.completeStep(_quest.id, 1);
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        if (param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id, 2)) {
            ServerMessager.addMessage("把显形水交给伊娃博士。");
            this.initQuestStep3();
            return;
        }
        if (param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id, 1)) {
            ServerMessager.addMessage("收集5个粘液、5个夜明珠、5个赤炎火苗给神谕祭司。");
            this.initQuestStep2();
        }
    }

    private function initQuestStep2():void {
        this._npc = MobileManager.getMobile(2, MobileType.NPC);
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
    }

    private function onNpc(param1:NpcEvent):void {
        var _loc2_:XML = null;
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
        param1.npcDefinition.resetFunctionalityData();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            if (param1.npcDefinition.id == 23) {
                _loc2_ = <node type="quest" name="雷克斯的秘密" params="30002_4"/>;
                param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 1);
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
            }
        } else if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            if (param1.npcDefinition.id == 23) {
                _loc2_ = <node type="quest" name="雷克斯的秘密" params="30002_5"/>;
                param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 1);
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
            }
        }
    }

    private function onUnit(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (event.content.params == "30002_4") {
            ItemManager.requestItemList(function ():void {
                if (ItemManager.getItemQuantityByReferenceId(400007) < 5 || ItemManager.getItemQuantityByReferenceId(400009) < 5 || ItemManager.getItemQuantityByReferenceId(400015) < 5) {
                    NpcDialog.show(23, "神谕祭司", [[0, "5个异蘑世界的<font color=\'#ffcc00\'>粘液</font>、5个夜晚荆棘林的<font color=\'#ffcc00\'>夜明珠</font>、5个蛮神战场的<font color=\'#ffcc00\'>赤炎火苗</font>。你都找齐了吗？"]], ["没呢，我现在就去找。"]);
                } else {
                    NpcDialog.show(23, "神谕祭司", [[0, "动作真快！谢谢你。显形水我已经给你准备好了，拿去给伊娃博士吧！"]], ["谢谢~~~"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                        QuestManager.completeStep(_quest.id, 2);
                    }]);
                }
            });
        } else if (event.content.params == "30002_5") {
            NpcDialog.show(23, "神谕祭司", [[0, "快把显形水交给伊娃博士吧！"]], ["嗯，我现在就去。"]);
        }
    }

    private function initQuestStep3():void {
        this.initQuestStep2();
    }

    override public function processMapDispose():void {
        this._npc = null;
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }
}
}
