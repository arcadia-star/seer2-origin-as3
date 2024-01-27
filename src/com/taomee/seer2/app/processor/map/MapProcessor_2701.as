package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_2701 extends HuanBeastChapter1Map {


    public function MapProcessor_2701(param1:MapModel) {
        step = 6;
        monsterId = 38;
        super(param1);
        _map.front["huokeMC"].visible = false;
        _map.front["huokeMC"].gotoAndStop(1);
    }
}
}
