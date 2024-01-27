package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_1700 extends MapProcessor {


    private var _yuese:MovieClip;

    public function MapProcessor_1700(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.sendNovice("0x10034075");
        this._yuese = _map.content["yuese"];
        this._yuese.addEventListener(MouseEvent.CLICK, this.onYuese);
    }

    private function onYuese(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("YueSeKingDownPanel"), "正在打开...");
    }

    override public function dispose():void {
        this._yuese.removeEventListener(MouseEvent.CLICK, this.onYuese);
        super.dispose();
    }
}
}
