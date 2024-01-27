package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.TotalHurtFightPetAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80021 extends MapProcessor {


    public function MapProcessor_80021(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        TotalHurtFightPetAct.getInstance().setup();
    }

    override public function dispose():void {
        super.dispose();
        TotalHurtFightPetAct.getInstance().dispose();
    }
}
}
