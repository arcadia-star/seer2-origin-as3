package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.RescueLunaAct;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80019 extends TitleMapProcessor {


    public function MapProcessor_80019(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        RescueLunaAct.getInstance().setup();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_437);
    }

    override public function dispose():void {
        super.dispose();
        RescueLunaAct.getInstance().dispose();
    }
}
}
