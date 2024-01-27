package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.shihunbeast.ShiHunBeastManger;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80389 extends MapProcessor {


    private var _shiHunBeast:ShiHunBeastManger;

    public function MapProcessor_80389(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._shiHunBeast = new ShiHunBeastManger(_map, 1457, 1);
        this._shiHunBeast.init();
    }

    override public function dispose():void {
        super.dispose();
        this._shiHunBeast.dispose();
    }
}
}
