package com.taomee.seer2.app.processor.quest.handler.branch.quest10004 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.inventory.events.InventoryEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.events.MouseEvent;

public class QuestMapHandler_10004_1320 extends BranchQuestMapHandler {


    private const COST_ITEM_ID:int = 400009;

    public function QuestMapHandler_10004_1320(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        var _loc1_:XML = <npc id="409" resId="409" name="" dir="1" width="25" height="50" pos="450,400"
                              actorPos="500,400" path="">
            <dialog npcId="409" npcName="" transport="1,300,400">
                <branch id="default" npcId="409" npcName="晓晓">
                    <node emotion="0"><![CDATA[如果你是萨伦帝国的人，请走开！我们身上已经没有你想要的东西了！]]></node>
                    <reply action="close"><![CDATA[听不懂你在说什么，再见！]]></reply>
                </branch>
            </dialog>
        </npc>;
        initNpc(_loc1_);
        tip = "到荆棘林采集1个夜明珠给晓晓。";
        this.addQuestAcceptListener();
    }

    private function addQuestAcceptListener():void {
        if (QuestManager.isAccepted(_questId)) {
            this.doQuestStepOne();
        }
    }

    override protected function onQuestAccept(param1:QuestEvent):void {
        super.onQuestAccept(param1);
        if (_questId == param1.questId) {
            this.doQuestStepOne();
        }
    }

    private function doQuestStepOne():void {
        if (!QuestManager.isStepComplete(10004, 1)) {
            ItemManager.requestItemList(this.onGetItemList);
        }
    }

    private function onGetItemList():void {
        var _loc1_:Array = ItemManager.getItemArr();
        if (ItemManager.getItemQuantityByReferenceId(this.COST_ITEM_ID) > 0) {
            this.completeStepOne();
        } else {
            ItemManager.addEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemAdded);
        }
    }

    private function onItemAdded(param1:InventoryEvent):void {
        if (param1.itemReferenceId == this.COST_ITEM_ID) {
            ItemManager.removeEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemAdded);
            this.completeStepOne();
        }
    }

    private function completeStepOne():void {
        QuestManager.completeStep(_questId, 1);
    }

    override protected function onQuestClick(param1:MouseEvent):void {
        if (QuestManager.isStepComplete(_questId, 2) && !QuestManager.isStepComplete(_questId, 3)) {
            DialogPanel.showForSimple(410, "月月", [[2, "问完你们的博士，请告诉我们结果，无论怎么，我们都非常感谢！"]], "别着急，我现在就去找伊娃博士问问。");
        } else if (QuestManager.isStepComplete(_questId, 3) && !QuestManager.isStepComplete(_questId, 4)) {
            DialogPanel.showForSimple(410, "月月", [[2, "你说博士有合体的容器，太好了，请你一定要帮帮我们！"]], "嗯，我去找博士问清楚！");
        } else if (QuestManager.isStepComplete(_questId, 4) && !QuestManager.isStepComplete(_questId, 5)) {
            DialogPanel.showForSimple(410, "月月", [[2, "你说博士给了你容器，只要到深幽沼泽收集荧光就可以了？太好了！"]], "嗯，我现在就去！");
        } else if (QuestManager.isStepComplete(_questId, 6) && !QuestManager.isStepComplete(_questId, 7)) {
            DialogPanel.showForSimple(409, "晓晓", [[0, "谢谢，合体容器我收下了，别为我们担心。天亮的时候，请你们再来这荆棘小道，无论成功还是失败，我们都会给你留下礼物，再见了！"]], "加油！天亮的荆棘小道见！");
        } else {
            DialogPanel.showForNpc(_npcDefinition);
        }
    }

    override protected function onSepComplete(param1:QuestEvent):void {
        if (param1.questId != _questId) {
            return;
        }
        if (QuestManager.isStepComplete(_questId, 2) && !QuestManager.isStepComplete(_questId, 3)) {
            ServerMessager.addMessage("到实验室找伊娃博士问问。");
        }
        if (QuestManager.isStepComplete(_questId, 6) && !QuestManager.isStepComplete(_questId, 7)) {
            ServerMessager.addMessage("到白天的荆棘小道来取礼物！");
        }
    }
}
}
