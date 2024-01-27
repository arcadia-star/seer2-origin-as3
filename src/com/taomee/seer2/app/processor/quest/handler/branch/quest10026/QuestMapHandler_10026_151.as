package com.taomee.seer2.app.processor.quest.handler.branch.quest10026 {
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

public class QuestMapHandler_10026_151 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_10026_151(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this._npc = MobileManager.getMobile(19, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpc, false, 1);
        }
    }

    private function onNpc(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        NpcDialog.show(19, "维拉", [[0, "嘻嘻，能让其他氏族的族民们喝到我们草目氏族的美酒，这也是我的荣幸！给！拿着！还要劳烦你送给吉吉导游咯！"]], ["（吉吉导游在地月氏族主城）"]);
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var _loc2_:String = param1.params;
        if (_loc2_ == "10026_0") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.completeStep(_quest.id, 1);
            ServerMessager.addMessage("已收集完成");
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
    }
}
}
