package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.worldWar.WorldWarProcessor;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_3810 extends MapProcessor {


    private var _worldWarProcessor:WorldWarProcessor;

    public function MapProcessor_3810(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this._worldWarProcessor = new WorldWarProcessor();
        StatisticsManager.sendNovice("0x10034219");
    }

    override public function dispose():void {
        this._worldWarProcessor.dispose();
        this._worldWarProcessor = null;
        super.dispose();
    }
}
}
