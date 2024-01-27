package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.LuoChaQingDiAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80506 extends MapProcessor {


    public function MapProcessor_80506(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        LuoChaQingDiAct.getInstance().setUp();
    }

    override public function dispose():void {
        LuoChaQingDiAct.getInstance().dispose();
        super.dispose();
    }
}
}
