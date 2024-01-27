package com.taomee.seer2.app.processor.quest.handler.branch.quest10218 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_10218_80126 extends QuestMapHandler {


    private var _captain:Mobile;

    public function QuestMapHandler_10218_80126(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10218) && QuestManager.isStepComplete(10218, 1) == false) {
            this.initStep1();
            this._captain = MobileManager.getMobile(1, MobileType.NPC);
            this._captain.gotoAndStop(1);
            this._captain.addEventListener(MouseEvent.MOUSE_OVER, this.onCaptainOver);
            this._captain.addEventListener(MouseEvent.MOUSE_OUT, this.onCaptainOut);
        }
    }

    private function onCaptainOver(param1:MouseEvent):void {
        this._captain.addEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
        this._captain.play();
    }

    private function onCaptainOut(param1:MouseEvent):void {
        this._captain.removeEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
        this._captain.gotoAndStop(1);
    }

    private function onCaptainPlay(param1:Event):void {
        if (this._captain.currentFrameIndex == 3) {
            this._captain.removeEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
            this._captain.gotoAndStop(3);
        }
    }

    private function initStep1():void {
        NpcDialog.show(1, "船长", [[0, ActorManager.actorInfo.nick + "你来的正好，现在阿卡迪亚星球正需要你！"]], ["是不是萨伦联合库贝萨的事情？"], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_1"), function ():void {
                NpcDialog.show(1, "船长", [[0, ActorManager.actorInfo.nick + "你愿意去找到他们并签署联盟契约吗？"]], ["使命必达！我一定会完成任务！"], [function ():void {
                    NpcDialog.show(1, "船长", [[0, "刻不容缓，快去伊娃博士那里领取联盟契约吧！她这会应该在实验室！"]], ["恩，我这就去。"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                        QuestManager.completeStep(10218, 1);
                    }]);
                }]);
            }, true, true);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.COPY, 80127);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this._captain) {
            this._captain.removeEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
            this._captain.removeEventListener(MouseEvent.MOUSE_OVER, this.onCaptainOver);
            this._captain.removeEventListener(MouseEvent.MOUSE_OUT, this.onCaptainOut);
        }
    }
}
}
