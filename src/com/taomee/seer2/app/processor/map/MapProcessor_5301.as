package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

public class MapProcessor_5301 extends MapProcessor {


    private const limitId:int = 202328;

    public function MapProcessor_5301(param1:MapModel) {
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
            if (count == 0) {
                spawnedPet = new SpawnedPet(80, 475, 0);
                MobileManager.addMobile(spawnedPet, MobileType.SPAWNED_PET);
            } else {
                AlertManager.showAlert("你已经获得了蓝宝石，赶紧继续你的冒险吧", function ():void {
                    ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"), "打开中...", "2");
                });
            }
        }
    }
}
}
