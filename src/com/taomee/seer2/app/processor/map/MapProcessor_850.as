package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_850 extends MapProcessor {


    public function MapProcessor_850(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_187);
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
