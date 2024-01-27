package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.holyPetProcessAct.HolyFightAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80056 extends MapProcessor {


    public function MapProcessor_80056(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        HolyFightAct.getInstance().setup(_map);
    }

    override public function dispose():void {
        HolyFightAct.getInstance().dispose();
        super.dispose();
    }
}
}
