package com.taomee.seer2.app.processor.quest.handler.main.quest81 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.InProgressMark;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;

public class QuestMapHandler_81_60 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_81_60(param1:QuestProcessor) {
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "81_1") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            this.initStep();
            QuestManager.accept(_quest.id);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        this._npc = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 50);
    }

    private function createNpc():void {
        var _loc1_:InProgressMark = null;
        if (!this._npc) {
            this._npc = MobileManager.getMobile(6, MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -200;
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep, false, 1);
        }
    }

    private function initStep():void {
        NpcDialog.show(6, "克拉克", [[1, "前往地球是一段很漫长的航程，这段时间你们也不能忘记提升自己的实力！只有不断进步，才能应对各种挑战！"]], [" 嗯！我会的！"], [function ():void {
            NpcDialog.show(6, "克拉克", [[1, "好了，不耽搁时间了，快去找其他船员吧！我期待你们的成功归来！"]], [" （前往机械室）"], [function ():void {
                initContinue();
            }]);
        }]);
    }

    private function initContinue():void {
        QuestManager.completeStep(questID, 2);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }
}
}
