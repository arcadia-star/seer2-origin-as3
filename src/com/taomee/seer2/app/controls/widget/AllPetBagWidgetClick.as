package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class AllPetBagWidgetClick implements IToolBarWidgetClick {

    public static const ALL_PET_BAG:String = "allPetBag";


    private var _widget:ToolBarWidget;

    public function AllPetBagWidgetClick() {
        super();
    }

    public function onWidgetClick(param1:MouseEvent):void {
        this._widget.showNormal();
        ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"), "正在打开精灵面板...");
        SoundEffects.playSoundMouseClick();
    }

    public function get widget():ToolBarWidget {
        return this._widget;
    }

    public function set widget(param1:ToolBarWidget):void {
        this._widget = param1;
    }
}
}
