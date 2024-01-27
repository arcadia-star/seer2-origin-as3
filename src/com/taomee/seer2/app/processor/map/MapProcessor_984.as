package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.yiteMorphAct.YiteMorphAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_984 extends MapProcessor {


    private var _yiteMorphAct:YiteMorphAct;

    public function MapProcessor_984(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._yiteMorphAct = new YiteMorphAct(_map);
    }

    override public function dispose():void {
        if (this._yiteMorphAct) {
            this._yiteMorphAct.dispose();
            this._yiteMorphAct = null;
        }
    }
}
}
