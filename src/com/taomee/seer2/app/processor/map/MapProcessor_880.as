package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activity.processor.LeiyiVSKaisa;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_880 extends MapProcessor {


    private var _kaiyi:LeiyiVSKaisa;

    public function MapProcessor_880(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFight();
    }

    private function initFight():void {
        this._kaiyi = new LeiyiVSKaisa();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_377);
    }

    override public function dispose():void {
        super.dispose();
        this._kaiyi.dispose();
    }
}
}
