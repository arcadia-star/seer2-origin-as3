package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.GaiYaWakeUpManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80470 extends MapProcessor {


    public function MapProcessor_80470(param1:MapModel) {
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
        GaiYaWakeUpManager.dispose();
    }

    override public function init():void {
        GaiYaWakeUpManager.init();
    }
}
}
