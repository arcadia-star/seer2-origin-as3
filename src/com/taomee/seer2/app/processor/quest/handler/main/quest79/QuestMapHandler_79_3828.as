package com.taomee.seer2.app.processor.quest.handler.main.quest79 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_79_3828 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_79_3828(param1:QuestProcessor) {
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(questID)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "79_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
            QuestManager.accept(_quest.id);
        }
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 3830);
    }

    private function onAccepted(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.createNpc();
        }
        if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 3830);
    }

    private function createNpc():void {
        var _loc1_:AcceptableMark = null;
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(650, 550));
            this._npc.resourceUrl = URLUtil.getNpcSwf(1016);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            _loc1_ = new AcceptableMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -150;
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep1);
        }
    }

    private function initStep1(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(1016, "里格", [[0, "小赛尔， 剩下的能量碎片极有可能在超能广场和军工厂。从这条路过去就是广场了。你们一定要注意安全。"]], ["（前往超能广场）"], [function ():void {
            QuestManager.completeStep(questID, 1);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
        }]);
    }

    override public function processMapDispose():void {
        MobileManager.removeMobile(this._npc, MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        super.processMapDispose();
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.initStep1);
        }
        this._npc = null;
    }
}
}
