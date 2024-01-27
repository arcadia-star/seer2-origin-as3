package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.dreamlandchest.DreamlandChestManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80432 extends MapProcessor {


    public function MapProcessor_80432(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        DreamlandChestManager.init(_map);
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
