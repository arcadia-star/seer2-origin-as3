package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activity.processor.FightSimoce;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_940 extends TitleMapProcessor {


    private var _fightHrader:FightSimoce;

    public function MapProcessor_940(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFight();
    }

    private function initFight():void {
        this._fightHrader = new FightSimoce();
    }

    override public function dispose():void {
        if (this._fightHrader) {
            this._fightHrader.dispose();
        }
        super.dispose();
    }
}
}
