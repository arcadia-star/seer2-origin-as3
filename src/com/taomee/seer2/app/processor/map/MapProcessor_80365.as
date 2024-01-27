package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;

public class MapProcessor_80365 extends MapProcessor {


    private const fight_id:uint = 791;

    private const pet_id:uint = 41;

    public function MapProcessor_80365(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        if (DateUtil.isInDayAndHourScope(3, 8, 14, 14, 0, 10)) {
            this.createPet();
        } else {
            AlertManager.showAlert("活动时间已经结束了,去传送室看看其他活动吧!", function ():void {
                SceneManager.changeScene(SceneType.LOBBY, 70);
            });
        }
    }

    private function createPet():void {
        var _loc2_:SpawnedPet = null;
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            _loc2_ = new SpawnedPet(this.pet_id, this.fight_id, 0);
            MobileManager.addMobile(_loc2_, MobileType.SPAWNED_PET);
            _loc1_++;
        }
    }
}
}
