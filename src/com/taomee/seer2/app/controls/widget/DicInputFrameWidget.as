package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.controls.ToolbarEvent;
import com.taomee.seer2.app.controls.widget.core.IWidgetable;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class DicInputFrameWidget extends Sprite implements IWidgetable {

    public static const DIC_INPUT:String = "DicInput";


    private var _mainUI:MovieClip;

    private var _btn:SimpleButton;

    private var _page:MovieClip;

    private var _dicBag:SimpleButton;

    private var _planetBag:SimpleButton;

    private var _isShow:Boolean;

    public function DicInputFrameWidget(param1:MovieClip) {
        super();
        this._mainUI = param1;
        addChild(this._mainUI);
        this.initMC();
        this.initEventListener();
    }

    private function initMC():void {
        this._btn = this._mainUI["btn"];
        this._isShow = false;
        this.updateTooltip();
        this.updateNonoPage();
    }

    private function updateTooltip():void {
        TooltipManager.addCommonTip(this._btn, "精灵图鉴");
    }

    private function initEventListener():void {
        this._btn.addEventListener(MouseEvent.CLICK, this.onNono);
    }

    private function onOut(param1:MouseEvent):void {
        this.onHide(null);
    }

    private function onHide(param1:ToolbarEvent):void {
        this._isShow = false;
        this.updateNonoPage();
    }

    private function onChange(param1:ToolbarEvent):void {
        if (param1.typeStr != DIC_INPUT && param1.status) {
            this._isShow = false;
            this.updateNonoPage();
        }
    }

    private function updateNonoPage():void {
    }

    private function onNono(param1:MouseEvent):void {
        if (PetInfoManager.getInitialPetInfo() == null) {
            AlertManager.showAlert("收集成长试炼中精灵可解锁图鉴哦!");
            return;
        }
        ModuleManager.toggleModule(URLUtil.getAppModule("PetDictionary"), "正在打开精灵图鉴...");
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_329);
        SoundEffects.playSoundMouseClick();
    }

    private function onPlanet(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("PlanetPanel"), "正在打开...");
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_330);
    }
}
}
