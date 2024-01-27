package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.controls.MinorToolBar;
import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class MonsterWidgetClick implements IToolBarWidgetClick {

    public static const MONSTER:String = "monster";


    private var _widget:ToolBarWidget;

    public function MonsterWidgetClick() {
        super();
    }

    public function onWidgetClick(param1:MouseEvent):void {
        this._widget.showNormal();
        ModuleManager.toggleModule(URLUtil.getAppModule("BagginsLogPanel"), "正在打开...");
        MinorToolBar.hideShine();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_324);
    }

    public function get widget():ToolBarWidget {
        return this._widget;
    }

    public function set widget(param1:ToolBarWidget):void {
        this._widget = param1;
    }
}
}
