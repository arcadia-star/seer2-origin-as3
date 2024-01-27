package com.taomee.seer2.app.processor.quest.handler.branch.quest10052 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

public class QuestMapHandler_10052_151 extends QuestMapHandler {


    public function QuestMapHandler_10052_151(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id)) {
            DialogPanel.addCloseEventListener(this.onCloseDialog);
        } else {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        }
    }

    private function onQuestAccept(param1:QuestEvent):void {
        if (_quest.id == param1.questId) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            NpcDialog.show(19, "维拉", [[0, "咕噜气泡！神马流星！我相信一定会是令人爆炸的绝顶杰作！"]], ["我这里就有哦！给你！", "（去漩涡峡谷、水脉主城！）"], [this.giveToYou, null]);
        }
    }

    private function onCloseDialog(param1:DialogCloseEvent):void {
        if (param1.params == "10052_0") {
            this.giveToYou();
        }
    }

    private function giveToYou():void {
        ItemManager.requestItemList(function ():void {
            if (ItemManager.getItemQuantityByReferenceId(400014) > 0 && ItemManager.getItemQuantityByReferenceId(400011) > 0) {
                NpcDialog.show(19, "维拉", [[1, "好！我就决定它叫——神马流星起泡酒！！对了，我这里少一个帮手，每天都需要有人来帮我采集这些食材……你看……"]], ["没问题，我明天再来帮你！"], [function ():void {
                    QuestManager.completeStep(_quest.id, 1);
                }]);
            } else {
                NpcDialog.show(19, "维拉", [[0, "嗯……果然是很难得到的食材吗……"]], ["（漩涡峡谷、水脉主城好像有我要的东西。）"], [null]);
            }
        });
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeCloseEventListener(this.onCloseDialog);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
    }
}
}
