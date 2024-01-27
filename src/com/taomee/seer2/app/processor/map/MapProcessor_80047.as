package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.rainOfSunAct.RainOfSunActTwo;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80047 extends TitleMapProcessor {


    private var _rainOfSunActTwo:RainOfSunActTwo;

    public function MapProcessor_80047(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._rainOfSunActTwo = new RainOfSunActTwo(_map);
    }

    override public function dispose():void {
        if (this._rainOfSunActTwo) {
            this._rainOfSunActTwo.dispose();
        }
        this._rainOfSunActTwo = null;
        super.dispose();
    }
}
}
