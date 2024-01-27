package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class MapProcessor_8022 extends TitleMapProcessor {


    private var _supermarketBtn:SimpleButton;

    public function MapProcessor_8022(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        _map.content.addEventListener(MouseEvent.CLICK, this.onMapcontentClick);
        _map.content["guangyite"].buttonMode = true;
        _map.content["guangyite"].mouseCihldren = false;
    }

    private function onMapcontentClick(param1:MouseEvent):void {
        switch (param1.target.name) {
            case "guangyite":
                ModuleManager.showAppModule("GuangyiteSuperPanel");
                break;
            case "dan":
                ModuleManager.showAppModule("YuanjingdanPanel");
        }
    }

    private function initSupermarket():void {
        this._supermarketBtn = _map.content["supermarketBtn"];
        TooltipManager.addCommonTip(this._supermarketBtn, "乐园商城");
        this._supermarketBtn.addEventListener(MouseEvent.CLICK, this.onOpenSupermarket);
    }

    private function onOpenSupermarket(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("SupermarketPanel"), "正在打开乐园商城...");
    }

    override public function dispose():void {
        _map.content.removeEventListener(MouseEvent.CLICK, this.onMapcontentClick);
        if (this._supermarketBtn) {
            this._supermarketBtn.removeEventListener(MouseEvent.CLICK, this.onOpenSupermarket);
            TooltipManager.remove(this._supermarketBtn);
            this._supermarketBtn = null;
        }
        super.dispose();
    }
}
}
