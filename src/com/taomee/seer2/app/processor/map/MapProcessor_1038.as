package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_1038 extends MapProcessor_1033 {


    public function MapProcessor_1038(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        StatisticsManager.sendNovice("0x1003455B");
    }
}
}
