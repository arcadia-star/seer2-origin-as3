package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.NpcChallenge;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_80526 extends TitleMapProcessor {


    public function MapProcessor_80526(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.iniNpc();
    }

    private function iniNpc():void {
        NpcChallenge.getInstance().init(3107, [1813, 1814, 1815]);
    }
}
}
