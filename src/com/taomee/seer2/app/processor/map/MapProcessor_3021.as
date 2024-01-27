package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_3021 extends HuanBeastChapter1Map {


    public function MapProcessor_3021(param1:MapModel) {
        step = 5;
        monsterId = 36;
        super(param1);
        _map.content["pipe2"].visible = false;
        _map.content["pipe2"].gotoAndStop(1);
    }
}
}
