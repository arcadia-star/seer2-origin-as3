package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.FireClawAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80043 extends MapProcessor {


    public function MapProcessor_80043(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        FireClawAct.setup();
    }

    override public function dispose():void {
        super.dispose();
        FireClawAct.dispose();
    }
}
}
