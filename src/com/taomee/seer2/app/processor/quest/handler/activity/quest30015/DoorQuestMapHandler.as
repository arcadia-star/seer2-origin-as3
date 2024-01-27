package com.taomee.seer2.app.processor.quest.handler.activity.quest30015 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.gameRule.door.core.ServerReward;
import com.taomee.seer2.app.gameRule.door.support.IUpDoorSupport;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class DoorQuestMapHandler extends QuestMapHandler {


    protected var _supportInstance:IUpDoorSupport;

    protected var questId:int;

    protected var toSceneId:int;

    protected var rewardList:Vector.<ServerReward>;

    private var stepId:int;

    public function DoorQuestMapHandler(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        var _loc1_:int = 0;
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.isWinWar()) {
            _loc1_ = 21;
            if (this.questId == 30019) {
                _loc1_ = 42;
            }
            if (this._supportInstance["doorLevel"] >= _loc1_) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
                if (!QuestManager.isStepComplete(this.questId, 1)) {
                    this.stepId = 1;
                    QuestManager.completeStep(this.questId, 1);
                    return;
                }
                if (QuestManager.isStepComplete(this.questId, 2) && !QuestManager.isStepComplete(this.questId, 3)) {
                    this.stepId = 3;
                    QuestManager.completeStep(this.questId, 3);
                }
            }
        }
    }

    private function completeStep(param1:QuestEvent):void {
        if (param1.questId == this.questId && param1.stepId == this.stepId) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
        }
    }
}
}
