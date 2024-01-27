package com.taomee.seer2.app.processor.quest.handler.branch.quest10232 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10232_10 extends QuestMapHandler {


    public function QuestMapHandler_10232_10(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(2)) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10232_0"), function ():void {
                NpcDialog.show(1, "辛迪船长", [[0, "紧急情况！根据氏族居民反映，所有灵兽都突然睡着了！"]], ["睡着了？"], [function ():void {
                    NpcDialog.show(400, "小赛尔", [[0, "船长，会不会是冬天到了，灵兽们都冬眠了？"]], ["所以就睡着啦"], [function ():void {
                        NpcDialog.show(1, "辛迪船长", [[0, "具体情况还不清楚，你先去目灵祭坛调查下。伊娃博士也会支援你的。"]], ["好的！"], [function ():void {
                            NpcDialog.show(400, "小赛尔", [[0, "是！船长！"]], ["立即就去！"], [function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                                QuestManager.completeStep(questID, 2);
                            }]);
                        }]);
                    }]);
                }]);
            });
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            if (param1.stepId == 2) {
                SceneManager.changeScene(SceneType.COPY, 80223);
            }
        }
    }
}
}
