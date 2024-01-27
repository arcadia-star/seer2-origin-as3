package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_1221 extends MapProcessor {


    private var _mapHandler:MapLayerGame;

    public function MapProcessor_1221(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._mapHandler = new MapLayerGame(_map);
        StatisticsManager.sendNovice("0x10034175");
    }

    override public function dispose():void {
        if (this._mapHandler) {
            this._mapHandler.dispose();
            this._mapHandler = null;
        }
        super.dispose();
    }
}
}
