package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.shootingCloud.ShootingCloud;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_740 extends MapProcessor {


    private var _shootingCloud:ShootingCloud;

    public function MapProcessor_740(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_268);
        this._shootingCloud = new ShootingCloud(_map);
    }

    override public function dispose():void {
        this._shootingCloud.dispose();
        this._shootingCloud = null;
        super.dispose();
    }
}
}
