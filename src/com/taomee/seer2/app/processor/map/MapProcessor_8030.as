package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class MapProcessor_8030 extends TitleMapProcessor {


    private var _supermarketBtn:MovieClip;

    private var _starBtn:MovieClip;

    private var btn:SimpleButton;

    public function MapProcessor_8030(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initSupermarket();
    }

    protected function showAct(param1:MouseEvent):void {
        ModuleManager.showAppModule("XingZhePanel");
    }

    private function initSupermarket():void {
        this._supermarketBtn = _map.content["shop"];
        this._starBtn = _map.content["star"];
        this.btn = _map.content["actBtn"];
        this.btn.addEventListener(MouseEvent.CLICK, this.showAct);
        TooltipManager.addCommonTip(this._supermarketBtn, "乐园商城");
        this._supermarketBtn.buttonMode = true;
        this._supermarketBtn.addEventListener(MouseEvent.CLICK, this.onOpenSupermarket);
        this._starBtn.buttonMode = true;
    }

    private function onOpenSupermarket(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("ShopPanel"), "正在打开乐园商城...");
    }

    private function onOpenStargazerFight(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("StargazerFightPanel"), "正在打开挑战面板...");
    }

    override public function dispose():void {
        this.btn.removeEventListener(MouseEvent.CLICK, this.showAct);
        if (this._supermarketBtn) {
            this._supermarketBtn.removeEventListener(MouseEvent.CLICK, this.onOpenSupermarket);
            TooltipManager.remove(this._supermarketBtn);
            this._supermarketBtn = null;
        }
        if (this._starBtn) {
            this._starBtn.removeEventListener(MouseEvent.CLICK, this.onOpenStargazerFight);
            TooltipManager.remove(this._starBtn);
            this._starBtn = null;
        }
        super.dispose();
    }
}
}
