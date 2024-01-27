package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.maiMaiDiProcessAct.MaiMaiDiProcessAct;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80105 extends TitleMapProcessor {


    private var _maiMaiDiProcessAct:MaiMaiDiProcessAct;

    public function MapProcessor_80105(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._maiMaiDiProcessAct = new MaiMaiDiProcessAct(_map);
    }

    override public function dispose():void {
        this._maiMaiDiProcessAct.dispose();
        super.dispose();
    }
}
}
