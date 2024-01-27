package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.ChiHuoYanDiAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80507 extends MapProcessor {


    public function MapProcessor_80507(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        ChiHuoYanDiAct.getInstance().setUp();
    }

    override public function dispose():void {
        ChiHuoYanDiAct.getInstance().dispose();
        super.dispose();
    }
}
}
