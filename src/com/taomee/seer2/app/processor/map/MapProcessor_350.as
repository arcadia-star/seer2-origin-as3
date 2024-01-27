package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.ChickenPK.ChickenPkManager;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_350 extends TitleMapProcessor {


    private var _chickenPkManager:ChickenPkManager;

    public function MapProcessor_350(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._chickenPkManager = new ChickenPkManager(_map);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_162);
    }

    override public function dispose():void {
        this._chickenPkManager.dispose();
        super.dispose();
    }
}
}
