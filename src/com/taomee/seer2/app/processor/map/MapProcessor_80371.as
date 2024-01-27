package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.earthSearchAct.EarthSearchTwoLayer;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80371 extends TitleMapProcessor {


    private var _earthTwo:EarthSearchTwoLayer;

    public function MapProcessor_80371(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._earthTwo = new EarthSearchTwoLayer(_map);
    }

    override public function dispose():void {
        this._earthTwo.dispose();
        this._earthTwo = null;
        super.dispose();
    }
}
}
