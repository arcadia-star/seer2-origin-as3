package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.stomach.StomachManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_8031 extends MapProcessor {


    private var _stomachManager:StomachManager;

    public function MapProcessor_8031(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._stomachManager = new StomachManager(_map);
    }

    override public function dispose():void {
        this._stomachManager.dispose();
        super.dispose();
    }
}
}
