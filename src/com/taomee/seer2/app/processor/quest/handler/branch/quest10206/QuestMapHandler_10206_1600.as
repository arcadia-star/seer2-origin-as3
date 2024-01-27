package com.taomee.seer2.app.processor.quest.handler.branch.quest10206 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10206_1600 extends QuestMapHandler {


    public function QuestMapHandler_10206_1600(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (QuestManager.isCanAccepted(10206)) {
        }
        if (QuestManager.isAccepted(10206) == false) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        }
        if (QuestManager.isStepComplete(10206, 1) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        }
        if (QuestManager.isAccepted(10206) == true && QuestManager.isStepComplete(10206, 1) == false) {
            this.step1();
        }
        if (QuestManager.isStepComplete(10206, 1) == true && QuestManager.isStepComplete(10206, 2) == false) {
            this.step2();
        }
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        this.step1();
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == 10206 && param1.stepId == 1) {
            this.step2();
        }
    }

    private function step1():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("PetRideGuideMovie"), function ():void {
            QuestManager.completeStep(10206, 1);
        });
    }

    private function step2():void {
        NpcDialog.show(337, "天龙骑士", [[0, "好啦！记得9月6日来这里哦！！这里还有许多骑宠在等你！"]], ["哦也！"], [function ():void {
            QuestManager.completeStep(10206, 2);
        }]);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }
}
}
