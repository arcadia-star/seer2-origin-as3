package com.taomee.seer2.app.processor.quest.handler.branch.quest10125 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_46;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10125_220 extends QuestMapHandler {


    private var aBao:MovieClip;

    public function QuestMapHandler_10125_220(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.unitClick);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.unitClick);
    }

    private function unitClick(param1:DialogPanelEvent):void {
        var _loc2_:String = (param1.content as DialogPanelEventData).params;
        if (_loc2_ == "abao_220_1") {
            this.checkQuest();
        }
    }

    private function checkQuest():void {
        if (!QuestManager.isAccepted(_quest.id)) {
            this.initAccept();
        }
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.showPanel();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.completeStep2();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            this.showPanel();
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && !QuestManager.isStepComplete(_quest.id, 5)) {
            this.showPanel();
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isStepComplete(_quest.id, 4)) {
            this.completeStep4();
        }
        if (QuestManager.isStepComplete(10125, 5) && !QuestManager.isStepComplete(10125, 6)) {
            this.completeStep6();
        }
    }

    private function completeStep6():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.NEWPLAYER_BUFF, this.getBuff);
    }

    private function getBuff(param1:ServerBuffer):void {
        var isComplete:Boolean;
        var i:int;
        var buff:ServerBuffer = param1;
        var state:Array = [];
        state.push(buff.readDataAtPostion(ServerBufferPosition_46.SCALE_STATE_23));
        state.push(buff.readDataAtPostion(ServerBufferPosition_46.SCALE_STATE_28));
        state.push(buff.readDataAtPostion(ServerBufferPosition_46.SCALE_STATE_31));
        state.push(buff.readDataAtPostion(ServerBufferPosition_46.SCALE_STATE_27));
        isComplete = true;
        i = 0;
        while (i < state.length) {
            if (state[i] == 0) {
                isComplete = false;
                break;
            }
            i++;
        }
        if (isComplete) {
            NpcDialog.show(405, "阿宝", [[0, "你好厉害啊！都卖光了！ "]], ["当然， 我可是天才。"], [function ():void {
                NpcDialog.show(405, "阿宝", [[0, "咱们今天收获颇丰，旅游经费轻松搞定啦！接下来我可要好好挑选旅行目的地了。 "]], ["加油！加油！"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                    QuestManager.completeStep(10125, 6);
                }]);
            }]);
        } else {
            this.showPanel();
        }
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 10125) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    private function completeStep4():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        QuestManager.completeStep(_quest.id, 4);
    }

    private function completeStep2():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        QuestManager.completeStep(_quest.id, 2);
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            this.showPanel();
        }
    }

    private function initAccept():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10125_0"), function ():void {
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(_quest.id);
        });
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.showPanel();
        }
    }

    private function showPanel():void {
        ModuleManager.toggleModule(URLUtil.getAppModule("ABaoTravelPanel"));
    }
}
}
