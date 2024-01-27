package com.taomee.seer2.app.processor.quest.handler.branch.quest10201 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10201_302 extends QuestMapHandler {


    public function QuestMapHandler_10201_302(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (QuestManager.isAccepted(10201) == false) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onThisAccept);
        }
        if (QuestManager.isStepComplete(10201, 1) == false || QuestManager.isStepComplete(10201, 2) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onThisStep);
        }
    }

    private function onThisAccept(param1:QuestEvent):void {
        if (param1.questId == 10201) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onThisAccept);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10201_0"));
        }
    }

    private function onThisStep(param1:QuestEvent):void {
        if (param1.questId == 10201) {
            if (param1.stepId == 1) {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10201_1"));
            } else if (param1.stepId == 2) {
                ModuleManager.toggleModule(URLUtil.getAppModule("YiBeastPanel"), "", "3");
            }
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onThisAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onThisStep);
        super.processMapDispose();
    }
}
}
