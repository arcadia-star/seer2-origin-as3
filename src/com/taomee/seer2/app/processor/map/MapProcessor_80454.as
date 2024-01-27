package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.miKaAwakenActThreePanel.MiKaAwakenActThreeAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80454 extends MapProcessor {


    private var _miKaAwakenThree:MiKaAwakenActThreeAct;

    public function MapProcessor_80454(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._miKaAwakenThree = new MiKaAwakenActThreeAct(_map);
    }

    override public function dispose():void {
        this._miKaAwakenThree.dispose();
        super.dispose();
    }
}
}
