package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.SavingEarthAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_1110 extends MapProcessor {


    public function MapProcessor_1110(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        SavingEarthAct.getInstance().setup();
    }

    override public function dispose():void {
        super.dispose();
        SavingEarthAct.getInstance().dispose();
    }
}
}
