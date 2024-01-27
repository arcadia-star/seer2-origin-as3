package com.taomee.seer2.app.processor.quest.handler.branch.quest10228 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_10228_900 extends QuestMapHandler {

    public static var haveStep:Boolean = false;


    public function QuestMapHandler_10228_900(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!isAccepted()) {
            this.initAccept();
        } else if (QuestManager.isStepComplete(10228, 1) == false) {
            this.initStep1();
        } else if (QuestManager.isStepComplete(10228, 1) == true && QuestManager.isStepComplete(10228, 2) == false) {
            this.onStep(null);
        }
    }

    private function initAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initStep1();
        }
    }

    private function initStep1():void {
        NpcDialog.show(148, "娜娜", [[1, "今天风刃氏族挂了什么风，一个接一个来问瞳魂兽的事。"]], [" 有人来问过了？ "], [function ():void {
            NpcDialog.show(148, "娜娜", [[1, "前面有个长的怪怪的老铁罐子也在到处找，他往流离街去了。"]], ["  怪怪的铁罐！好像知道是谁了！ "], [function ():void {
                NpcDialog.show(400, "小赛尔", [[0, "谢谢！我现在就去追他！"]], ["  不会是那个怪博士吧！ "], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                    QuestManager.completeStep(questID, 1);
                }]);
            }]);
        }]);
    }

    private function onStep(param1:QuestEvent):void {
        if (param1 == null || param1.questId == questID && param1.stepId == 1) {
            haveStep = true;
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            SceneManager.changeScene(SceneType.LOBBY, 920);
        }
    }
}
}
