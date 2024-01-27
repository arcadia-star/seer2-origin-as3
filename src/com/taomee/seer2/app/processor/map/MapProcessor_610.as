package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.gameRule.spt.SptKaniYaSupport;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_610 extends MapProcessor {


    private var _sptSupport:SptKaniYaSupport;

    public function MapProcessor_610(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._sptSupport = new SptKaniYaSupport();
        this._sptSupport.init(_map);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_175);
    }

    override public function dispose():void {
        this._sptSupport.dispose();
        this._sptSupport = null;
    }
}
}
