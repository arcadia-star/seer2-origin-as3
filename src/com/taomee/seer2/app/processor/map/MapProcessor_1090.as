package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.pandaMan.PandaManager;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_1090 extends TitleMapProcessor {


    private var _pandaManager:PandaManager;

    public function MapProcessor_1090(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this._pandaManager = new PandaManager();
        this._pandaManager.setup();
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
