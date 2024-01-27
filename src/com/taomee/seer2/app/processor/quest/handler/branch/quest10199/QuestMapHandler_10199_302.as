package com.taomee.seer2.app.processor.quest.handler.branch.quest10199 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10199_302 extends QuestMapHandler {


    public function QuestMapHandler_10199_302(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        if (QuestManager.isStepComplete(10199, 4) == true && QuestManager.isStepComplete(10199, 5) == false) {
            this.complete();
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == 10199 && param1.stepId == 2) {
            ModuleManager.toggleModule(URLUtil.getAppModule("YiBeastPanel"), "", "2");
        } else if (param1.questId == 10199 && param1.stepId == 4) {
            this.complete();
        }
    }

    private function complete():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10199_0"), function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "原来是翼灵兽的羽毛啊，太好了，最后的一只灵兽终于也出现了！"]], ["Ye！太棒了！"], [function ():void {
                QuestManager.completeStep(10199, 5);
            }]);
        });
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        super.processMapDispose();
    }
}
}
