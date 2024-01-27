package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_213 extends TitleMapProcessor {


    public function MapProcessor_213(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_137);
    }

    override public function dispose():void {
    }
}
}
