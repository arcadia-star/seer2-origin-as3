package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class MapProcessor_3704 extends MapProcessor {


    private const limitId:int = 202328;

    public function MapProcessor_3704(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        ActiveCountManager.requestActiveCount(this.limitId, this.getCount);
    }

    private function getCount(param1:uint, param2:uint):void {
        var spawnedPet:SpawnedPet = null;
        var type:uint = param1;
        var count:uint = param2;
        if (type == this.limitId) {
            if (count == 1) {
                spawnedPet = new SpawnedPet(82, 476, 0);
                MobileManager.addMobile(spawnedPet, MobileType.SPAWNED_PET);
            } else {
                AlertManager.showAlert("你已经获得了红宝石，赶紧赶快去找汪总管吧", function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                    QuestManager.completeStep(10195, 3);
                });
            }
        }
    }

    private function onStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        SceneManager.changeScene(SceneType.LOBBY, 330);
    }

    override public function dispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        super.dispose();
    }
}
}
