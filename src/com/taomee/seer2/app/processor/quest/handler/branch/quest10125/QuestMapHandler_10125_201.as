package com.taomee.seer2.app.processor.quest.handler.branch.quest10125 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_46;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;

public class QuestMapHandler_10125_201 extends QuestMapHandler {


    private var winNum:int;

    private var _npc:Mobile;

    public function QuestMapHandler_10125_201(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
    }

    override public function processMapComplete():void {
        super.processMapDispose();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            ServerBufferManager.getServerBuffer(ServerBufferType.NEWPLAYER_BUFF, this.getBuff);
            MonsterManager.hideAllMonster();
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (this.winNum >= 1 && this.winNum < 4) {
            if (FightManager.isJustWinFight()) {
                NpcDialog.show(29, "哈瑞", [[4, "不错哦,你赢了! "]], ["再来一场"], [function ():void {
                    FightManager.startFightWithWild(165);
                }]);
            } else {
                NpcDialog.show(29, "哈瑞", [[4, "嘿嘿！知道我的厉害了吧！ "]], ["哼！刚才我只是热身而已"], [function ():void {
                    FightManager.startFightWithWild(165);
                }]);
            }
        } else if (this.winNum < 1) {
            NpcDialog.show(29, "哈瑞", [[4, "饰品设计图？我这有好多，平时有空我就会画几张玩玩！ "]], ["能给我一张吗？"], [function ():void {
                NpcDialog.show(29, "哈瑞", [[4, "可以啊！但是我现在好无聊，咱们较量较量吧！如果你能打赢我三次，这堆设计图随你挑。 "]], ["OK，开始吧！", "额！我才不要和你对战呢。"], [function ():void {
                    FightManager.startFightWithWild(165);
                }]);
            }]);
        }
        event.stopImmediatePropagation();
        event.stopPropagation();
    }

    private function getBuff(param1:ServerBuffer):void {
        this.winNum = param1.readDataAtPostion(ServerBufferPosition_46.WIN_HARUI_NUM);
        this._npc = MobileManager.getMobile(29, MobileType.NPC);
        this._npc.removeOverHeadMark();
        this._npc.addOverHeadMark(new AcceptableMark());
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick, false, 1000);
        if (FightManager.isJustWinFight()) {
            ++this.winNum;
            ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF, ServerBufferPosition_46.WIN_HARUI_NUM, this.winNum);
        }
        this.checkWinNum();
    }

    private function checkWinNum():void {
        if (this.winNum >= 3) {
            NpcDialog.show(400, "我", [[0, "哇喔，这张设计图里的饰品好漂亮哦，赶紧拿给阿宝看看吧！"]], ["返回幽静浅滩！"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                QuestManager.completeStep(_quest.id, 1);
            }]);
        }
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            MonsterManager.showAllMonster();
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            SceneManager.changeScene(SceneType.LOBBY, 220);
        }
    }
}
}
