package com.taomee.seer2.app.plantSystem {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.utils.URLUtil;

public class PlantLoadLand {


    private var _fun:Function;

    public function PlantLoadLand(param1:uint, param2:Function) {
        super();
        this._fun = param2;
        QueueLoader.load(URLUtil.getRes("plant/seedAnimation/" + param1 + ".swf"), LoadType.SWF, this.onUpdateSeedComplete);
    }

    private function onUpdateSeedComplete(param1:ContentInfo):void {
        this._fun(param1);
    }
}
}
