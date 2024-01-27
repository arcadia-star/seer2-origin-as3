package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.GaiYaAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80036 extends MapProcessor {


    private var gaiyaAct:GaiYaAct;

    public function MapProcessor_80036(param1:MapModel) {
        this.gaiyaAct = new GaiYaAct();
        super(param1);
    }

    override public function init():void {
        this.gaiyaAct.setup();
    }

    override public function dispose():void {
        this.gaiyaAct.dispose();
        super.dispose();
    }
}
}
