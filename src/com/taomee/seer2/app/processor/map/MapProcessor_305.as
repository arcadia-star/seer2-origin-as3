package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.party.PartyManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_305 extends MapProcessor {


    private var _party:PartyManager;

    public function MapProcessor_305(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._party = new PartyManager();
        this._party.setup();
    }

    override public function dispose():void {
        this._party.dispose();
        this._party = null;
    }
}
}
