package com.taomee.seer2.app.processor.quest.handler.activity.quest30017 {
import com.taomee.seer2.app.gameRule.door.atletico.AtleticoDoorSupport;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.activity.quest30015.DoorQuestMapHandler;

public class QuestMapHandler_30017_408 extends DoorQuestMapHandler {


    public function QuestMapHandler_30017_408(param1:QuestProcessor) {
        questId = 30017;
        toSceneId = 84;
        _supportInstance = AtleticoDoorSupport.getInstance();
        super(param1);
    }
}
}
