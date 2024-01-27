package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.yuelingshouevolution.YueLingShouEvolutionManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80456 extends MapProcessor {


    public function MapProcessor_80456(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        YueLingShouEvolutionManager.setup(_map);
    }

    override public function dispose():void {
        YueLingShouEvolutionManager.dispose();
    }
}
}
