package com.taomee.seer2.app.processor.quest.handler.branch.quest10203 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10203_60 extends QuestMapHandler {


    public function QuestMapHandler_10203_60(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(10203)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onaccept);
        }
    }

    private function onaccept(param1:QuestEvent):void {
        var e:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onaccept);
        QuestManager.completeStep(10203, 1);
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10203_1"), function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "啊,原来凯萨在追击它们，我们有帮手了。"]], ["教官可有计划？"], [function ():void {
                NpcDialog.show(6, "克拉克", [[0, "看来我们得帮助凯萨，那场大雨是什么？"]], ["好奇怪的大雨。"], [function ():void {
                    NpcDialog.show(6, "小赛尔", [[0, "没错。我们该出发了，小赛尔。"]], ["出发！"], [function ():void {
                        changeScene();
                    }]);
                }]);
            }]);
        });
    }

    private function changeScene():void {
        if (SceneManager.active.mapID == 261) {
            return;
        }
        SceneManager.changeScene(SceneType.LOBBY, 261);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onaccept);
        super.processMapDispose();
    }
}
}
