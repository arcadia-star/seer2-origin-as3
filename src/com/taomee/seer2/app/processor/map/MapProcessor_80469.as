package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.dragonchroniclesManager.DragonChroniclesFirstSeasonManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80469 extends MapProcessor {


    public function MapProcessor_80469(param1:MapModel) {
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
        DragonChroniclesFirstSeasonManager.dispose();
    }

    override public function init():void {
        DragonChroniclesFirstSeasonManager.init(3);
    }
}
}
