package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.moPetProcessAct.MoGetPetAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80055 extends MapProcessor {


    private var _catchPetAct:MoGetPetAct;

    public function MapProcessor_80055(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._catchPetAct = new MoGetPetAct(_map);
    }

    override public function dispose():void {
        if (this._catchPetAct) {
            this._catchPetAct.dispose();
            this._catchPetAct = null;
        }
        super.dispose();
    }
}
}
