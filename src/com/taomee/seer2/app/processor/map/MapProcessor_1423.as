package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;

public class MapProcessor_1423 extends QinBeastChapter1Map {


    public function MapProcessor_1423(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        (_map.content["stoneDragging"] as MovieClip).gotoAndStop(1);
    }
}
}
