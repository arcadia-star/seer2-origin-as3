package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class MapProcessor_991 extends MapProcessor {


    public function MapProcessor_991(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this._map.content["arrow"].visible = true;
        TooltipManager.addCommonTip(this._map.content["openBtn"], "噬神届108星");
        this._map.content["openBtn"].addEventListener(MouseEvent.CLICK, this.onOpen);
        this._map.content["openBtn2"].addEventListener(MouseEvent.CLICK, this.onOpen2);
    }

    private function onOpen(param1:MouseEvent):void {
        this._map.content["arrow"].visible = false;
        ModuleManager.showModule(URLUtil.getAppModule("ShiHunTaPanel"), "正在打开拔保护偷汤面板...");
    }

    private function onOpen2(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("XiLuFeiDuActPanel"), "正在打开拔保护偷汤面板...");
    }
}
}
