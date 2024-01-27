package com.taomee.seer2.app.processor.quest.handler.main.quest83 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class QuestMapHandler_83_80354 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_83_80354(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.GUDIE_ARENA5) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            QuestManager.completeStep(_quest.id, 6);
        } else if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 6)) {
            this._npc = MobileManager.getMobile(111112, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        var _loc2_:Object = new Object();
        _loc2_.index = 4;
        ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"), "", _loc2_);
    }

    private function onNpc(param1:MouseEvent):void {
        FightManager.startFightWithGudiePet(100000, null, null, null, 1, 3);
    }
}
}
