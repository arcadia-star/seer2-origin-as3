package com.taomee.seer2.app.processor.quest.handler.activity.quest30051 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_30051_240 extends QuestMapHandler {


    private var fightId:uint = 618;

    public function QuestMapHandler_30051_240(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(3)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.clickCheck);
        }
    }

    protected function clickCheck(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (DialogPanelEventData(event.content).params == "playFull3") {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30051_2"), function ():void {
                FightManager.addEventListener(FightStartEvent.FIGHT_OVER, fightOver);
                FightManager.startFightWithWild(fightId);
            });
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == 30051 && param1.stepId == 3) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            SceneManager.changeScene(SceneType.LOBBY, 213);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.clickCheck);
    }

    protected function fightOver(param1:FightStartEvent):void {
        var event:FightStartEvent = param1;
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.fightOver);
        if (FightManager.isWinWar()) {
            NpcDialog.show(626, "晨璨", [[0, "可恶的小兵，欺人太甚，这回让你看到了我的好看。哼~！"]], ["想偷袭我大姐大，没门"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                QuestManager.completeStep(30051, 3);
            }]);
        }
    }
}
}
