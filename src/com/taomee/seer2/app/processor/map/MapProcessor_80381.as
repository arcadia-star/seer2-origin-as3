package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.guessDevilHouseAct.GuessDevilHouseAct;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80381 extends TitleMapProcessor {


    private var _guessDevilAct:GuessDevilHouseAct;

    public function MapProcessor_80381(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._guessDevilAct = new GuessDevilHouseAct(_map);
    }

    override public function dispose():void {
        this._guessDevilAct.dispose();
        super.dispose();
    }
}
}
