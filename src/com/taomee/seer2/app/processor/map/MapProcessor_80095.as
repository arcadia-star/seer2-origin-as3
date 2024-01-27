package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.findMoInSnowAct.FindMoInSnowAct;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80095 extends TitleMapProcessor {


    public function MapProcessor_80095(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        FindMoInSnowAct.getInstance().setup(_map);
    }

    override public function dispose():void {
        FindMoInSnowAct.getInstance().dispose();
        super.dispose();
    }
}
}
