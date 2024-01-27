package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

public class MapProcessor_37002 extends MapProcessor {


    public function MapProcessor_37002(param1:MapModel) {
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
        ActorManager.showRemoteActor = true;
    }

    override public function init():void {
        ActorManager.showRemoteActor = false;
        ActiveCountManager.requestActiveCount(202133, this.setCount);
    }

    private function setCount(param1:int, param2:int):void {
        if (param1 == 202133 && param2 == 5) {
            this.getFightNum();
        } else {
            ModuleManager.toggleModule(URLUtil.getAppModule("MaiBeastPanel"), "打开中...", "2");
        }
    }

    private function getFightNum():void {
        var _loc2_:SpawnedPet = null;
        var _loc1_:int = 0;
        while (_loc1_ < 5) {
            _loc2_ = new SpawnedPet(82, 269, 0);
            MobileManager.addMobile(_loc2_, MobileType.SPAWNED_PET);
            _loc1_++;
        }
    }
}
}
