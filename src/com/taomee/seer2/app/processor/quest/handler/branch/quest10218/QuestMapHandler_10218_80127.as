package com.taomee.seer2.app.processor.quest.handler.branch.quest10218 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10218_80127 extends QuestMapHandler {


    public function QuestMapHandler_10218_80127(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10218) && QuestManager.isStepComplete(10218, 2) == false) {
            this.initStep2();
        }
    }

    private function initStep2():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_2"), function ():void {
            NpcDialog.show(2, "伊娃", [[0, ActorManager.actorInfo.nick + "你终于来了，船长应该都和你说了吧。"]], ["是的，博士，你的精灵好帅啊！"], [function ():void {
                NpcDialog.show(2, "伊娃", [[0, "呵呵，现在事关紧要，这张契约你先拿着！"]], ["好的。"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_2_0"), function ():void {
                        NpcDialog.show(2, "伊娃", [[0, "现在还差冰沁氏族和飞翼氏族还没有签署契约，你可以去找寻两个氏族的族长签订契约吗？"]], ["没问题，看我的吧！"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                            QuestManager.completeStep(10218, 2);
                        }]);
                    }, true, true);
                }]);
            }]);
        }, true, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.COPY, 80128);
    }
}
}
