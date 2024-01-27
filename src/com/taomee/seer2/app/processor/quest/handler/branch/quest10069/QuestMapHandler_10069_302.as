package com.taomee.seer2.app.processor.quest.handler.branch.quest10069 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;

public class QuestMapHandler_10069_302 extends QuestMapHandler {


    public function QuestMapHandler_10069_302(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        DialogPanel.addCloseEventListener(this.onCloseDialog);
    }

    private function onCloseDialog(param1:DialogCloseEvent):void {
        var evt:DialogCloseEvent = param1;
        if (evt.params == "10069") {
            ItemManager.requestItemList(function ():void {
                if (ItemManager.getItemQuantityByReferenceId(400001) > 1) {
                    NpcDialog.show(34, "麦铁", [[0, "非常感谢你……但愿这顶华冠，能够为真正的王者所冕。"]], ["嗯嗯，肯定的！"], [function ():void {
                        QuestManager.completeStep(_quest.id, 1);
                        DialogPanel.removeCloseEventListener(onCloseDialog);
                    }]);
                } else {
                    NpcDialog.show(34, "麦铁", [[0, "你还没有得到2组黄铁矿……再去找找吧！"]], ["好的！"], [null]);
                }
            });
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeCloseEventListener(this.onCloseDialog);
    }
}
}
