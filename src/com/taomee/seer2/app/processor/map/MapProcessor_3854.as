package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.gameRule.spt.SptSaLaiErSupport;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_3854 extends MapProcessor {


    public function MapProcessor_3854(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        SptSaLaiErSupport.getInstance().init(_map);
    }

    override public function dispose():void {
        super.dispose();
        SptSaLaiErSupport.getInstance().dispose();
    }
}
}
