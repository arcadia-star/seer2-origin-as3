package com.taomee.seer2.app.quest.target {
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.data.TargetDefinition;

public class QuestStepTargetMine extends BaseQuestStepTarget {


    public function QuestStepTargetMine(param1:Quest, param2:TargetDefinition) {
        super(param1, param2);
    }

    override public function start():void {
        super.start();
        ItemManager.addEventListener1(ItemEvent.MINE_SUCCESS, this.onMineSuccess);
    }

    override public function finish():void {
        ItemManager.removeEventListener1(ItemEvent.MINE_SUCCESS, this.onMineSuccess);
        super.finish();
    }

    private function onMineSuccess(param1:ItemEvent):void {
        if (_params != "" && uint(param1.content) == uint(_params)) {
            ItemManager.removeEventListener1(ItemEvent.MINE_SUCCESS, this.onMineSuccess);
            execute();
        }
    }
}
}
