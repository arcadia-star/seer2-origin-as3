package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.TheSpriteOfDragonManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80484 extends MapProcessor {


    public function MapProcessor_80484(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        TheSpriteOfDragonManager.instance.init();
    }

    override public function dispose():void {
        TheSpriteOfDragonManager.instance.dispose();
    }
}
}
