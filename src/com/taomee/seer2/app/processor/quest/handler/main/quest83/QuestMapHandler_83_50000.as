package com.taomee.seer2.app.processor.quest.handler.main.quest83 {
import com.taomee.seer2.app.newGuidStatistics.NewGuidStatisManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_83_50000 extends QuestMapHandler {


    private var _mc2:MovieClip;

    public function QuestMapHandler_83_50000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 3) && !QuestManager.isStepComplete(questID, 4)) {
            this.quest4();
        }
    }

    private function quest4():void {
        this._mc2 = _processor.resLib.getMovieClip("mc2");
        _map.front.addChild(this._mc2);
        ModuleManager.addEventListener("PetSpiritTrainPanel", ModuleEvent.SHOW, this.onModule);
    }

    private function onStroageHide(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("PetSpiritTrainPanel", ModuleEvent.HIDE, this.onStroageHide);
        ModuleManager.removeEventListener("PetSpiritTrainPanel", ModuleEvent.SHOW, this.onModule);
        ModuleManager.removeEventListener("PetSpiritGuidePanel", ModuleEvent.DISPOSE, this.onModule);
        DisplayUtil.removeForParent(this._mc2);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.completeStep(_quest.id, 4);
    }

    private function onModule(param1:ModuleEvent):void {
        NewGuidStatisManager.statisHandle(23);
        DisplayUtil.removeForParent(this._mc2);
        ModuleManager.removeEventListener("PetSpiritTrainPanel", ModuleEvent.SHOW, this.onModule);
        ModuleManager.addEventListener("PetSpiritTrainPanel", ModuleEvent.HIDE, this.onStroageHide);
        ModuleManager.addEventListener("PetSpiritGuidePanel", ModuleEvent.DISPOSE, this.onModuleHide);
    }

    private function onModuleHide(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("PetSpiritTrainPanel", ModuleEvent.HIDE, this.onStroageHide);
        ModuleManager.removeEventListener("PetSpiritTrainPanel", ModuleEvent.SHOW, this.onModule);
        ModuleManager.removeEventListener("PetSpiritGuidePanel", ModuleEvent.DISPOSE, this.onModule);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.completeStep(_quest.id, 4);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        var _loc2_:Object = new Object();
        _loc2_.index = 2;
        ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"), "", _loc2_);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        ModuleManager.removeEventListener("PetSpiritGuidePanel", ModuleEvent.DISPOSE, this.onModule);
        ModuleManager.removeEventListener("PetSpiritTrainPanel", ModuleEvent.HIDE, this.onStroageHide);
        ModuleManager.removeEventListener("PetSpiritTrainPanel", ModuleEvent.SHOW, this.onStroageHide);
        DisplayUtil.removeForParent(this._mc2);
    }
}
}
