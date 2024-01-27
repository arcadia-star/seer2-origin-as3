package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.QingFengBaiDiAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80504 extends MapProcessor {


    public function MapProcessor_80504(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        QingFengBaiDiAct.getInstance().setUp();
    }

    override public function dispose():void {
        QingFengBaiDiAct.getInstance().dispose();
        super.dispose();
    }
}
}
