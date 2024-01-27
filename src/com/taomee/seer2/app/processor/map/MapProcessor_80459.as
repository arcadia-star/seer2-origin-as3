package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.FireGodCommandManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80459 extends MapProcessor {


    public function MapProcessor_80459(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        FireGodCommandManager.init(_map);
    }

    override public function dispose():void {
        super.dispose();
        FireGodCommandManager.dispose();
    }
}
}
