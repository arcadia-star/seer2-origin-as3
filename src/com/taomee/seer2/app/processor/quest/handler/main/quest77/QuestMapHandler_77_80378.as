package com.taomee.seer2.app.processor.quest.handler.main.quest77 {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_77_80378 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_77_80378(param1:QuestProcessor) {
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        _map.content["door"].visible = false;
        if (!QuestManager.isAccepted(questID)) {
            QuestManager.accept(questID);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccepted);
        }
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.createNpc();
        }
        if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
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
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
        _map.content.addChild(_loc2_);
        _loc2_.x = 520;
        _loc2_.y = 280;
    }

    private function initStep1(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(757, "萤火虫", [[0, "我……就送你们……到这里了……接下来的探险……加油……"]], [" 萤火虫，谢谢你，再见！"], [function ():void {
            QuestManager.completeStep(questID, 1);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
        }]);
    }

    private function createNpc():void {
        var _loc1_:AcceptableMark = null;
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(650, 300));
            this._npc.resourceUrl = URLUtil.getNpcSwf(757);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            _loc1_ = new AcceptableMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -80;
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep1);
        }
    }
}
}
