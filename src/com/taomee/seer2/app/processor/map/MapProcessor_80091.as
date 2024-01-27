package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.ChristmasQiaoBaAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80091 extends MapProcessor {


    public function MapProcessor_80091(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        ChristmasQiaoBaAct.getInstance().setup();
    }

    override public function dispose():void {
        ChristmasQiaoBaAct.getInstance().dispose();
    }
}
}
