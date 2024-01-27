package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.DogSipaikeAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80111 extends MapProcessor {


    public function MapProcessor_80111(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        DogSipaikeAct.getInstance().setup();
    }

    override public function dispose():void {
        super.dispose();
        DogSipaikeAct.getInstance().dispose();
    }
}
}
