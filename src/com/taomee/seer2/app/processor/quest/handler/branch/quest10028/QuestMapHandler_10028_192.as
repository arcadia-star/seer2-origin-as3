package com.taomee.seer2.app.processor.quest.handler.branch.quest10028 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;

import flash.events.MouseEvent;

public class QuestMapHandler_10028_192 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_10028_192(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this._npc = MobileManager.getMobile(31, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpc, false, 1);
        }
    }

    private function onNpc(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        NpcDialog.show(31, "巴尔卡", [[0, "玛里？！他还好吗？记得让他好好锻炼身体！将来一定会成为火幻氏族最勇猛的勇士！"]], ["（亲笔签名照搞定）"]);
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var _loc2_:String = param1.params;
        if (_loc2_ == "10028_0") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            ServerMessager.addMessage("已收集完成");
            QuestManager.completeStep(_quest.id, 1);
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
    }
}
}
