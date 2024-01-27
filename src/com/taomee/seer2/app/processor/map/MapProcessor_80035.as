package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.specialPetAct.SpecialPetOneAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80035 extends MapProcessor {


    private var _specialPetOneAct:SpecialPetOneAct;

    public function MapProcessor_80035(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._specialPetOneAct = new SpecialPetOneAct(_map);
    }

    override public function dispose():void {
        if (this._specialPetOneAct) {
            this._specialPetOneAct.dispose();
            this._specialPetOneAct = null;
        }
        super.dispose();
    }
}
}
