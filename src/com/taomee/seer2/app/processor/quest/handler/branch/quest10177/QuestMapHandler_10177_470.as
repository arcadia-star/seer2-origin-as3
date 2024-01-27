package com.taomee.seer2.app.processor.quest.handler.branch.quest10177 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10177_470 extends QuestMapHandler {


    public function QuestMapHandler_10177_470(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(1) || isNeedCompleteStep(2) || isNeedCompleteStep(3) || isNeedCompleteStep(5) || isNeedCompleteStep(6)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == questID) {
            if (param1.stepId == 1) {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10177_0"));
            } else if (param1.stepId == 2) {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10177_1"));
            } else if (param1.stepId == 3) {
                ModuleManager.toggleModule(URLUtil.getAppModule("HuanBeastPanel"), "", "3");
            } else if (param1.stepId == 5) {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10177_1"));
            } else if (param1.stepId == 6) {
                SceneManager.changeScene(SceneType.LOBBY, 302);
            }
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onStep);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }
}
}
