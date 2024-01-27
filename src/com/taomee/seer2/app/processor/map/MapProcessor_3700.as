package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.gameRule.spt.Spt3700Support;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_3700 extends MapProcessor {


    private var _sptSupport:Spt3700Support;

    public function MapProcessor_3700(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._sptSupport = new Spt3700Support();
        this._sptSupport.init(_map);
    }

    override public function dispose():void {
        this._sptSupport.dispose();
    }
}
}
