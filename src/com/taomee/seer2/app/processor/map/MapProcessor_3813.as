package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.FightBoDeAct;
import com.taomee.seer2.app.processor.activity.fightVsBarry.FightVsDick;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_3813 extends MapProcessor {


    private var _fighVsDick:FightVsDick;

    public function MapProcessor_3813(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this._fighVsDick = new FightVsDick(_map);
        FightBoDeAct.instance.setup();
    }

    override public function dispose():void {
        super.dispose();
        if (this._fighVsDick) {
            this._fighVsDick.dispose();
            this._fighVsDick = null;
        }
        FightBoDeAct.instance.dispose();
    }
}
}
