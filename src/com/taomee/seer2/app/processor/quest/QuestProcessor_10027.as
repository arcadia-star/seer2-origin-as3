package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;

public class QuestProcessor_10027 extends QuestProcessor {


    public function QuestProcessor_10027(param1:Quest) {
        super(param1);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
    }

    private function onMapComplete(param1:SceneEvent):void {
        var _loc2_:uint = 0;
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
        if (QuestManager.isComplete(10024) && QuestManager.isComplete(10025) && QuestManager.isComplete(10026)) {
            if (QuestManager.isCanAccepted(10027)) {
                QuestManager.accept(10027);
            }
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false) {
            _loc2_ = uint(_quest.getStepData(1, 0));
            if (_loc2_ == 10) {
                QuestManager.completeStep(_quest.id, 1);
            }
        }
    }
}
}
