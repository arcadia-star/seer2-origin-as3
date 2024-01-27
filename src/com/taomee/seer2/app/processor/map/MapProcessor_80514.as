package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.yiteSuper.AnyiteSuperManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80514 extends MapProcessor {


    public function MapProcessor_80514(param1:MapModel) {
        super(param1);
        AnyiteSuperManager.initMap(param1);
    }

    override public function dispose():void {
        AnyiteSuperManager.leaveMap();
    }
}
}
