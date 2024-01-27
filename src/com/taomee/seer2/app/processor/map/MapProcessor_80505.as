package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.HunYuanHeiDiAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80505 extends MapProcessor {


    public function MapProcessor_80505(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        HunYuanHeiDiAct.getInstance().setUp();
    }

    override public function dispose():void {
        HunYuanHeiDiAct.getInstance().dispose();
        super.dispose();
    }
}
}
