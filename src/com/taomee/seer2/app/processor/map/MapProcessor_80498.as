package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.zhaoLingShouEvolution.ZhaoLingShouEvolutionManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_80498 extends MapProcessor {


    private var zhaoLingShou:ZhaoLingShouEvolutionManager;

    public function MapProcessor_80498(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.zhaoLingShou = new ZhaoLingShouEvolutionManager(_map);
    }

    override public function dispose():void {
        this.zhaoLingShou.dispose();
        super.dispose();
    }
}
}
