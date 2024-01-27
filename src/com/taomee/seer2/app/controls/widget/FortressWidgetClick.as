package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;

public class FortressWidgetClick implements IToolBarWidgetClick {

    public static const FORTRESS:String = "fortress";


    private var _widget:ToolBarWidget;

    public function FortressWidgetClick() {
        super();
    }

    public function onWidgetClick(param1:MouseEvent):void {
        this._widget.showNormal();
        SceneManager.changeScene(SceneType.LOBBY, 81);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_321);
    }

    public function get widget():ToolBarWidget {
        return this._widget;
    }

    public function set widget(param1:ToolBarWidget):void {
        this._widget = param1;
    }
}
}
