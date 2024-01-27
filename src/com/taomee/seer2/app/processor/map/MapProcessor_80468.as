package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.fightHolySkyAct.FightHolySkyAct;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80468 extends TitleMapProcessor {


    public function MapProcessor_80468(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        FightHolySkyAct.getInstance().setup(_map);
    }

    override public function dispose():void {
        FightHolySkyAct.getInstance().dispose();
        super.dispose();
    }
}
}
