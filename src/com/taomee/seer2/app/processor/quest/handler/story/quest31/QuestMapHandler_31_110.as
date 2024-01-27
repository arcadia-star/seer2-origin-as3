package com.taomee.seer2.app.processor.quest.handler.story.quest31 {
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_31_110 extends QuestMapHandler {


    private var _resultInfo:FightResultInfo;

    public function QuestMapHandler_31_110(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (!_quest.isStepCompete(1)) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
                PetInfoManager.addEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
            }
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "31_2") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
            QuestManager.completeStep(_quest.id, 1);
        }
    }

    private function onQuestComplete(param1:QuestEvent):void {
        ModuleManager.addEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }

    private function onPetLevelUp(param1:PetInfoEvent):void {
        PetInfoManager.removeEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
        this._resultInfo = param1.content.resultInfo;
    }

    private function teacherPlayerHandler(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
    }

    override public function processMapDispose():void {
        PetInfoManager.removeEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
        ModuleManager.removeEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        super.processMapDispose();
    }
}
}
