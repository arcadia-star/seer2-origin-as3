package com.taomee.seer2.app.processor.activity.nextyearActivity {
import com.taomee.seer2.core.map.MapModel;

public class ActivityThis {


    private var _map:MapModel;

    public function ActivityThis(param1:MapModel) {
        super();
        this._map = param1;
    }

    public function dispose():void {
        this._map = null;
    }
}
}
