package com.taomee.seer2.app.activity.processor {
import com.taomee.seer2.app.activity.data.ActivityDefinition;
import com.taomee.seer2.app.activity.processor.grassBlade.ChrismasSpecialGrassEvent;

import flash.display.MovieClip;

public class GrassBlade extends ActivityProcessor {

    private static const CHRISMAS_EVENT_ID:uint = 11;


    public var pet:MovieClip;

    private var _specialEvent:WaterGrassCSE;

    public function GrassBlade(param1:ActivityDefinition) {
        _relatedMapIDArr = [100, 101];
        super(param1);
    }

    override public function start():void {
        this._specialEvent = new ChrismasSpecialGrassEvent(CHRISMAS_EVENT_ID, this);
        super.start();
    }

    override public function refresh():void {
        super.refresh();
    }

    override public function dispose():void {
        this._specialEvent.dispose();
        this._specialEvent = null;
        super.dispose();
    }
}
}
