package com.taomee.seer2.app.processor.quest.handler.branch.quest10202 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10202_60 extends QuestMapHandler {


    public function QuestMapHandler_10202_60(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(10202) == true && QuestManager.isAccepted(10202) == false) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        }
        if (QuestManager.isAccepted(10202) == true && QuestManager.isStepComplete(10202, 1) == false) {
            this.onAccept();
        }
        if (QuestManager.isStepComplete(10202, 1) == true && QuestManager.isStepComplete(10202, 2) == false) {
            this.changeScene();
        }
    }

    private function onAccept(param1:QuestEvent = null):void {
        var e:QuestEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10202_1"), function ():void {
            NpcDialog.show(6, "克拉克", [[0, "不好，他们两个看来是已经用尽全力在打斗，我们必须过去帮助伊鲁达，否则后果不堪设想。"]], ["走。。。。"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1);
                QuestManager.completeStep(10202, 1);
            }]);
        });
    }

    private function onStep1(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1);
        this.changeScene();
    }

    private function changeScene():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10202_2"), function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 2913);
        });
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1);
        super.processMapDispose();
    }
}
}
