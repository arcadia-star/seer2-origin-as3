package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

public class MapProcessor_7101 extends QinBeastChapter1Map {


    public function MapProcessor_7101(param1:MapModel) {
        super(param1);
        DisplayObjectUtil.removeFromParent(_map.content["sptFYS"]);
    }
}
}
