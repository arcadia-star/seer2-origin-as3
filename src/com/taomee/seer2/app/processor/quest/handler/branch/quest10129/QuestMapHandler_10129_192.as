package com.taomee.seer2.app.processor.quest.handler.branch.quest10129 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10129_192 extends QuestMapHandler {


    public function QuestMapHandler_10129_192(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        var _loc1_:int = 0;
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStart);
            _loc1_ = int(FightManager.currentFightRecord.initData.positionIndex);
            if (SceneManager.prevSceneType == SceneType.ARENA && _loc1_ == 168) {
                this.fightOK();
            }
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onStep1CompleteHandler);
            QuestManager.completeStep(_quest.id, 1);
        }
    }

    private function onStart(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if ((evt.content as DialogPanelEventData).params == "10129_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStart);
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "阿宝它要去骰子星寻宝，我想邀请您去送送它（今天这句话说了好多次喽……）"]], [" 您愿意吗？"], [function ():void {
                NpcDialog.show(31, "巴尔卡", [[0, "又是送别，我离开故乡有多久了？（陷入沉思20秒…）哦，要我去送它对吗？你愿意和我挑战一下吗？我太需要斗志了，尤其是这个季节!"]], [" 好啊！赶紧开始吧！"], [function ():void {
                    FightManager.startFightWithWild(168);
                }]);
            }]);
        }
    }

    private function fightOK():void {
        NpcDialog.show(31, "巴尔卡", [[0, "我好多了。那我们出发吧！我会告诉阿宝一些战斗的经验，或许对它去骰子星有帮助！如果没有记错，那星球上有狼妖！"]], [" 狼妖？！那要赶紧告诉阿宝，我们赶紧走！"], [function ():void {
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
            QuestManager.accept(_quest.id);
        }]);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onStep1CompleteHandler);
        QuestManager.completeStep(_quest.id, 1);
    }

    private function onStep1CompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep1CompleteHandler);
        ModuleManager.toggleModule(URLUtil.getAppModule("SayGood_byeToAboPanel"), "正在打开面板...");
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStart);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep1CompleteHandler);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
    }
}
}
