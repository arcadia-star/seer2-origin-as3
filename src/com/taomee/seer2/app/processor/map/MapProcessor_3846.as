package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.yuanhunbeast.YuanHunBeastManger;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_3846 extends MapProcessor {


    public function MapProcessor_3846(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        YuanHunBeastManger.init(_map);
    }

    override public function dispose():void {
        super.dispose();
        YuanHunBeastManger.dispose();
    }
}
}
