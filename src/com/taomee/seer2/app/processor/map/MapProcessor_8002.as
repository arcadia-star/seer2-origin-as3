package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.map800Activity.BlackFight;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_8002 extends TitleMapProcessor {


    private var _blackFight:BlackFight;

    public function MapProcessor_8002(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._blackFight = new BlackFight();
    }

    override public function dispose():void {
        if (this._blackFight) {
            this._blackFight.dispose();
        }
        super.dispose();
    }
}
}
