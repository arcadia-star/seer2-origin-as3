package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

public class MapProcessor_6103 extends QinBeastChapter1Map {


    public function MapProcessor_6103(param1:MapModel) {
        super(param1);
        DisplayObjectUtil.removeFromParent(_map.content["kaniyaya"]);
    }
}
}
