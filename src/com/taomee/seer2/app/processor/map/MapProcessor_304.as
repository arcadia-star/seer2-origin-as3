package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class MapProcessor_304 extends MapProcessor {


    public function MapProcessor_304(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_166);
    }

    private function onClickStone(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("ChallengePhenixPanel"));
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
