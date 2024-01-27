package com.taomee.seer2.app.processor.quest.handler.branch.quest10053 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_10053;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_10053_110 extends QuestMapHandler {


    public function QuestMapHandler_10053_110(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id)) {
            DialogPanel.addCloseEventListener(this.onCloseDialog);
        } else if (QuestManager.isCanAccepted(_quest.id)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        }
    }

    private function onQuestAccept(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            SceneManager.changeScene(SceneType.LOBBY, 100);
        }
    }

    private function onCloseDialog(param1:DialogCloseEvent):void {
        var cnt:int = 0;
        var evt:DialogCloseEvent = param1;
        if (evt.params == "10053_0") {
            cnt = (_processor as QuestProcessor_10053).count;
            if (cnt >= 10) {
                NpcDialog.show(16, "神目酋长", [[0, "再一次向你表示感谢！如果你每个星期都能来祝我们一臂之力那就太好了！"]], [" 放心！下周五我还会来帮忙的！"], [function ():void {
                    QuestManager.completeStep(_quest.id, 1);
                }]);
            } else {
                NpcDialog.show(16, "神目酋长", [[0, "你还没有完成任务，前线的压力依然很大！记好了，每周五的14:00-15:00和19:00-20:00，信奉广场，一切拜托了！（现已击退 " + cnt + "个小兵）"]], ["明白"], [null]);
            }
        } else if (evt.params == "10053_1") {
            SceneManager.changeScene(SceneType.LOBBY, 100);
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeCloseEventListener(this.onCloseDialog);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
    }
}
}
