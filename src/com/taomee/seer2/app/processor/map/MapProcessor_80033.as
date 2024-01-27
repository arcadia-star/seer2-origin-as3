package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.LeiyiGunPetAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80033 extends MapProcessor {


    public function MapProcessor_80033(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        LeiyiGunPetAct.setup();
    }

    override public function dispose():void {
        LeiyiGunPetAct.dispose();
        super.dispose();
    }
}
}
