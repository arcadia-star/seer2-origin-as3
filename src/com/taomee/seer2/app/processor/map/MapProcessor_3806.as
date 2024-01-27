package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class MapProcessor_3806 extends TitleMapProcessor {


    public function MapProcessor_3806(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        if (!QuestManager.isAccepted(10193)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        }
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 10193) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY, 3301);
        }
    }

    override public function dispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        super.dispose();
    }
}
}
