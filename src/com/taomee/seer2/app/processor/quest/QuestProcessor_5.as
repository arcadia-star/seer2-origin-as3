package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.quest.Quest;

public class QuestProcessor_5 extends QuestProcessor {

    private static const TERUY_PETID:uint = 1013;


    public function QuestProcessor_5(param1:Quest) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (Boolean(_quest.isStepCompete(2)) && !_quest.isStepCompete(4)) {
            this.setSubstitute();
        }
    }

    public function setSubstitute():void {
        ActorManager.getActor().startTransform(TERUY_PETID);
    }

    public function removeSubstitute():void {
        ActorManager.getActor().stopTransform();
    }
}
}
