package com.taomee.seer2.app.processor.quest.handler.branch.quest10195 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class QuestMapHandler_10195_330 extends QuestMapHandler {


    private var npc:Mobile;

    public function QuestMapHandler_10195_330(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!QuestManager.isAccepted(10195)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        }
        if (!QuestManager.isStepComplete(10195, 2)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        }
        if (QuestManager.isStepComplete(10195, 3) && !QuestManager.isComplete(10195)) {
            this.npc = MobileManager.getMobile(43, MobileType.NPC);
            if (this.npc) {
                this.npc.addEventListener(MouseEvent.CLICK, this.onClick, false, 1);
            }
        }
    }

    private function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        e.stopImmediatePropagation();
        NpcDialog.show(43, "汪总管", [[0, "那么快就得到了？看吧，屌丝还是可以逆袭的。"]], [" 切，你只会说风凉话。"], [function ():void {
            NpcDialog.show(43, "汪总管", [[0, "废话别多说了，拿上你的宝石，我带你去找我们的老板吧！"]], ["嗯，好的！"], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10195_1"), function ():void {
                    QuestManager.completeStep(10195, 4);
                }, true, true);
            }]);
        }]);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 10195) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY, 5001);
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == 10195 && param1.stepId == 2) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"), "", "2");
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        if (this.npc) {
            this.npc.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        super.processMapDispose();
    }
}
}
