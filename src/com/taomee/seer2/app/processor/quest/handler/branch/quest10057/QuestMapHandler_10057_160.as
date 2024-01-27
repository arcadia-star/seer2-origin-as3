package com.taomee.seer2.app.processor.quest.handler.branch.quest10057 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_10057;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;

public class QuestMapHandler_10057_160 extends QuestMapHandler {


    public function QuestMapHandler_10057_160(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        DialogPanel.addCloseEventListener(this.onCloseDialog);
    }

    private function onCloseDialog(param1:DialogCloseEvent):void {
        var cnt:int = 0;
        var evt:DialogCloseEvent = param1;
        if (evt.params == "10057") {
            cnt = (_processor as QuestProcessor_10057).count;
            if (cnt >= 5) {
                NpcDialog.show(23, "洛水", [[0, "感谢你，因为有你的协助，我们才能一次一次将敌人击溃。请收下，这是水脉氏族族人的一点心意。希望下周你还能来帮助我们。"]], ["这是我应该的！"], [function ():void {
                    QuestManager.completeStep(_quest.id, 1);
                    DialogPanel.removeCloseEventListener(onCloseDialog);
                }]);
            } else {
                NpcDialog.show(23, "洛水", [[0, "不，萨伦帝国的士气依然高昂……击败缇娜女王5次或许可以挫败他们的战意！（现已击败缇娜女王 " + cnt + "次）"]], ["好的！"], [null]);
            }
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeCloseEventListener(this.onCloseDialog);
    }
}
}
