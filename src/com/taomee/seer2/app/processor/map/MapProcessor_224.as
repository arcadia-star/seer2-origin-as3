package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.AbaoTravel.AbaoTravelSayByebye;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_224 extends TitleMapProcessor {


    private var _abaoTravel:AbaoTravelSayByebye;

    public function MapProcessor_224(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initAbaoTravel();
    }

    private function initAbaoTravel():void {
        this._abaoTravel = new AbaoTravelSayByebye();
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
