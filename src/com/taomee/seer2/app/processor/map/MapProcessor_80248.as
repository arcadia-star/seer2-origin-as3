package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.ZhuQueProcessAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80248 extends MapProcessor {


    private var _zhuQueAct:ZhuQueProcessAct;

    public function MapProcessor_80248(param1:MapModel) {
        this._zhuQueAct = new ZhuQueProcessAct();
        super(param1);
    }

    override public function init():void {
        this._zhuQueAct.setup();
    }

    override public function dispose():void {
        this._zhuQueAct.dispose();
        super.dispose();
    }
}
}
