package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.FengHuangEvolutionManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80460 extends MapProcessor {


    public function MapProcessor_80460(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        FengHuangEvolutionManager.init(_map);
    }

    override public function dispose():void {
        super.dispose();
        FengHuangEvolutionManager.dispose();
    }
}
}
