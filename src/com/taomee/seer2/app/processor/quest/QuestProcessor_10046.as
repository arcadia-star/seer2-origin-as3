package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.inventory.events.InventoryEvent;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestProcessor_10046 extends QuestProcessor {

    private static const ITEM_RESID:uint = 400027;


    public function QuestProcessor_10046(param1:Quest) {
        super(param1);
        if (QuestManager.isAccepted(10046)) {
            this.updateQuestStatus();
        } else {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccepted);
        }
    }

    private function onQuestAccepted(param1:QuestEvent):void {
        if (param1.questId == 10046) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccepted);
            this.updateQuestStatus();
        }
    }

    private function updateQuestStatus():void {
        var _loc1_:uint = uint(_quest.getStepData(1, 0));
        if (QuestManager.isStepComplete(10046, 1) == false && _loc1_ >= 2) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            QuestManager.completeStep(_quest.id, 1);
        } else if (QuestManager.isStepComplete(10046, 1) == false) {
            ItemManager.addEventListener(InventoryEvent.QUANTITY_ADD, this.onItemAdd);
        }
    }

    private function onItemAdd(param1:InventoryEvent):void {
        var _loc2_:uint = 0;
        if (param1.itemReferenceId == ITEM_RESID) {
            _loc2_ = uint(_quest.getStepData(1, 0));
            _loc2_++;
            _quest.setStepData(1, 0, _loc2_);
            QuestManager.setStepBufferServer(10046, 1);
            if (_loc2_ >= 2) {
                ItemManager.removeEventListener(InventoryEvent.ADD, this.onItemAdd);
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
                QuestManager.completeStep(_quest.id, 1);
            } else {
                ServerMessager.addMessage("还需要收集 <font color=\'#ffcc00\'>" + (2 - _loc2_) + " </font> 个 <font color=\'#ffcc00\'>霓虹灯</font>");
            }
        }
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            if (Boolean(SceneManager.active) && SceneManager.active.type == SceneType.LOBBY) {
                ServerMessager.addMessage("找到足够的霓虹灯啦，快回 <font color=\'#ffcc00\'>小屋</font> 看看装修进度吧");
            }
        }
    }

    override public function dispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccepted);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        ItemManager.removeEventListener(InventoryEvent.ADD, this.onItemAdd);
        super.dispose();
    }
}
}
