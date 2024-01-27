package com.taomee.seer2.app.processor.quest.handler.branch.quest10204 {
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
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class QuestMapHandler_10204_60 extends QuestMapHandler {


    private var kelake:Mobile;

    public function QuestMapHandler_10204_60(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10204) == false) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        }
        if (QuestManager.isComplete(10204) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
        if (QuestManager.isAccepted(10204) == true && QuestManager.isComplete(10204) == false) {
            this.kelake = MobileManager.getMobile(6, MobileType.NPC);
            if (this.kelake) {
                this.kelake.addEventListener(MouseEvent.CLICK, this.onClick, false, 1);
            }
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (this.kelake) {
            this.kelake.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        super.processMapDispose();
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        ModuleManager.toggleModule(URLUtil.getAppModule("EidolonPanel"));
    }

    private function onClick(param1:MouseEvent):void {
        this.kelake.removeEventListener(MouseEvent.CLICK, this.onClick);
        param1.stopImmediatePropagation();
        if (QuestManager.isAccepted(10204) == true && QuestManager.isStepComplete(10204, 1) == false) {
            this.step1();
        } else if (QuestManager.isStepComplete(10204, 1) == true && QuestManager.isStepComplete(10204, 2) == false) {
            this.step2();
        } else if (QuestManager.isStepComplete(10204, 2) == true && QuestManager.isStepComplete(10204, 3) == false) {
            this.step3();
        } else if (QuestManager.isStepComplete(10204, 3) == true && QuestManager.isStepComplete(10204, 4) == false) {
            this.step4();
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == 10204) {
            switch (param1.stepId) {
                case 1:
                    this.step2();
                    break;
                case 2:
                    this.step3();
                    break;
                case 3:
                    this.step4();
                    break;
                case 4:
            }
        }
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        this.step1();
    }

    private function step1():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10204_1"), function ():void {
            NpcDialog.show(6, "克拉克", [[0, "就差最后的幻蹄雷电了，我们必须得抢先一步找到哥布林精灵，否则，当幻灵骑士团聚齐，哥布林又被掠走的话。"]], [" …………"], [function ():void {
                NpcDialog.show(6, "克拉克", [[0, "约瑟王将被萨伦召唤出，到时候萨伦的阴谋就会得逞了。"]], ["啊？……"], [function ():void {
                    NpcDialog.show(6, "克拉克", [[0, "不好，监控器显示……"]], ["查看监控器"], [function ():void {
                        QuestManager.completeStep(10204, 1);
                    }]);
                }]);
            }]);
        });
    }

    private function step2():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10204_2"), function ():void {
            QuestManager.completeStep(10204, 2);
        });
    }

    private function step3():void {
        ModuleManager.toggleModule(URLUtil.getAppModule("FindPetPlace"));
    }

    private function step4():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10204_3"), function ():void {
            QuestManager.completeStep(10204, 4);
        });
    }
}
}
