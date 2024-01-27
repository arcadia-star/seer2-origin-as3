package com.taomee.seer2.app.processor.quest.handler.branch.quest10132 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

public class FindSheetQuest extends QuestMapHandler {


    protected var stepId:int;

    protected var fightId:int;

    protected var petId:int;

    protected var itemId:int;

    public function FindSheetQuest(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        Connection.removeCommandListener(CommandSet.PET_SPAWN_1103, this.onMessage);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(this.stepId)) {
            this.createMonster();
        }
    }

    private function onREquestSuccess():void {
        var _loc3_:SpawnedPet = null;
        var _loc1_:int = ItemManager.getItemQuantityByReferenceId(this.itemId);
        var _loc2_:int = int(FightManager.currentFightRecord.initData.positionIndex);
        if (_loc1_ == 9 && FightManager.isJustWinFight() && _loc2_ == this.fightId) {
            _loc1_++;
        }
        if (_loc1_ >= 10) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            QuestManager.completeStep(questID, this.stepId);
        } else {
            _loc3_ = new SpawnedPet(this.petId, this.fightId, 0);
            MobileManager.addMobile(_loc3_, MobileType.SPAWNED_PET);
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == questID && param1.stepId == this.stepId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            ModuleManager.toggleModule(URLUtil.getAppModule("EyeBeastPanel"), "打开中", "2");
        }
    }

    private function createMonster():void {
        if (questID == 10134 && this.stepId == 2 && SceneManager.active.mapID == 2030) {
            ItemManager.requestItemList(this.onREquestSuccess);
        } else {
            Connection.addCommandListener(CommandSet.PET_SPAWN_1103, this.onMessage);
        }
    }

    private function onMessage(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.PET_SPAWN_1103, this.onMessage);
        ItemManager.requestItemList(this.onREquestSuccess);
    }
}
}
