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

public class QuestMapHandler_81_30 extends QuestMapHandler {


    private var _npc:Mobile;

    public function QuestMapHandler_81_30(param1:QuestProcessor) {
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && QuestManager.isStepComplete(questID, 2) && QuestManager.isStepComplete(questID, 3) && QuestManager.isStepComplete(questID, 4) && !QuestManager.isStepComplete(questID, 5)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "81_4") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
            this.initStep();
        }
    }

    private function createNpc():void {
        var _loc1_:InProgressMark = null;
        if (!this._npc) {
            this._npc = MobileManager.getMobile(7, MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -150;
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep, false, 1);
        }
    }

    private function initStep():void {
        NpcDialog.show(7, "娜威拉", [[0, "哈，这还差不多。告诉你们哦，在宇宙中，有一个神秘的地方，传说，那里被电磁覆盖。没有人知道那里面有什么，因为一旦进去，就很难出来。你们可要小心哦！"]], ["嗯，我们会注意的"], [function ():void {
            NpcDialog.show(7, "娜威拉", [[0, "其他的也没有什么啦，希望你们可以平安回到地球！"]], ["谢啦！"], [function ():void {
                NpcDialog.show(766, "小梦", [[0, "拜访的差不多啦，回去找辛迪船长吧。"]], [" 好的 "], [function ():void {
                    initContinue();
                }]);
            }]);
        }]);
    }

    private function initContinue():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.completeStep(questID, 5);
    }

    private function onStepComplete(param1:QuestEvent):void {
        this._npc = null;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 10);
    }

    override public function processMapDispose():void {
        this._npc = null;
        super.processMapDispose();
    }
}
}
