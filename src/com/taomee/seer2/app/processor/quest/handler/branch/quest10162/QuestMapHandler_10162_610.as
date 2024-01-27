package com.taomee.seer2.app.processor.quest.handler.branch.quest10162 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.utils.IDataInput;

public class QuestMapHandler_10162_610 extends QuestMapHandler {


    public function QuestMapHandler_10162_610(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false && SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.doWin();
            }
        }
    }

    private function doWin():void {
        SwapManager.swapItem(923, 1, this.onSwap);
    }

    private function onSwap(param1:IDataInput):void {
        var _loc2_:SwapInfo = new SwapInfo(param1, false);
        ServerBufferManager.updateServerBuffer(ServerBufferType.Leiyi_Fit_Kaisa, 14, 1);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepHandler);
        QuestManager.completeStep(_quest.id, 2);
    }

    private function onStepHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepHandler);
        SceneManager.changeScene(SceneType.LOBBY, 50);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepHandler);
    }
}
}
