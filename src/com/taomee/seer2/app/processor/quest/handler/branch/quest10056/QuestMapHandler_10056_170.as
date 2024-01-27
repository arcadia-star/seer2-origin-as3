package com.taomee.seer2.app.processor.quest.handler.branch.quest10056 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

public class QuestMapHandler_10056_170 extends QuestMapHandler {


    public function QuestMapHandler_10056_170(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        DialogPanel.addCloseEventListener(this.onCloseDialog);
    }

    private function onCloseDialog(param1:DialogCloseEvent):void {
        if (param1.params == "10056") {
            this.startFight();
        }
    }

    private function startFight():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwictchComplete);
        FightManager.startFightBinaryWild(65);
    }

    private function onSwictchComplete(param1:SceneEvent):void {
        var evt:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex == 65) {
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwictchComplete);
                if (FightManager.fightWinnerSide == FightSide.RIGHT) {
                    NpcDialog.show(25, "莱斯", [[4, "看，双胞胎的配合很强力吧！"]], ["继续继续！", "还是算啦"], [function ():void {
                        startFight();
                    }, null]);
                } else {
                    NpcDialog.show(26, "莱克", [[2, "莱斯！他好厉害！我想他明天还来陪我们玩儿！"]], ["哼哼，我是专业的，当然厉害。"], [function ():void {
                        NpcDialog.show(25, "莱斯", [[4, "如果你愿意的话，明天再来找我们吧？作为答谢，这个给你！"]], ["谢谢啦！"], [function ():void {
                            QuestManager.completeStep(_quest.id, 1);
                            DialogPanel.addCloseEventListener(onCloseDialog);
                        }]);
                    }]);
                }
            }
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeCloseEventListener(this.onCloseDialog);
    }
}
}
