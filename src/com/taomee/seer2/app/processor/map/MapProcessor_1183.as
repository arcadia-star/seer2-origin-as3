package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;

import flash.events.MouseEvent;

public class MapProcessor_1183 extends MapProcessor {


    public function MapProcessor_1183(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        _map.content.addEventListener(MouseEvent.CLICK, this.onMapClick);
        super.init();
    }

    private function onMapClick(param1:MouseEvent):void {
        var _loc2_:String = String(param1.target.name);
        switch (_loc2_) {
            case "mainBtn":
                ModuleManager.showAppModule("YufengPvpPanel");
                break;
            case "npc0":
            case "npc1":
                ModuleManager.showAppModule("YufengExchagnePanel");
        }
    }

    override public function dispose():void {
        _map.content.removeEventListener(MouseEvent.CLICK, this.onMapClick);
        super.dispose();
    }
}
}
