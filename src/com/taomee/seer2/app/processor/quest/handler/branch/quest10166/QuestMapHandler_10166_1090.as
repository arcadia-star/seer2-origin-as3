package com.taomee.seer2.app.processor.quest.handler.branch.quest10166 {
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.inventory.events.InventoryEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_10166_1090 extends QuestMapHandler {


    public function QuestMapHandler_10166_1090(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            ItemManager.addEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemAdded);
            ItemManager.requestItemList(function ():void {
                var _loc1_:uint = uint(ItemManager.getItemQuantityByReferenceId(400822));
                if (_loc1_ >= 5) {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                    QuestManager.completeStep(_quest.id, 1);
                }
            });
        } else if (QuestManager.isCanAccepted(_quest.id)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        }
    }

    private function onAccept(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            ItemManager.addEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemAdded);
        }
    }

    private function onItemAdded(param1:InventoryEvent):void {
        var _loc2_:uint = 0;
        if (param1.itemReferenceId == 400822) {
            _loc2_ = uint(ItemManager.getItemQuantityByReferenceId(400822));
            if (_loc2_ >= 5) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
                QuestManager.completeStep(_quest.id, 1);
                return;
            }
            ServerMessager.addMessage("还需要" + (5 - _loc2_) + "条玄玉鲤鱼！");
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        ItemManager.removeEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemAdded);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        ItemManager.removeEventListener(InventoryEvent.UPDATE_QUANTITY, this.onItemAdded);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }
}
}
