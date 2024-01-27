package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.kaXiuSiAct.KaXiuSiAct;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80052 extends TitleMapProcessor {


    public function MapProcessor_80052(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        KaXiuSiAct.getInstance().setup(_map);
    }

    override public function dispose():void {
        KaXiuSiAct.getInstance().dispose();
        super.dispose();
    }
}
}
