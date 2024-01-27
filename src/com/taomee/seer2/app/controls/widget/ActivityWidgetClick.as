package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.cookie.SharedObjectManager;
import com.taomee.seer2.core.manager.VersionManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.net.SharedObject;

public class ActivityWidgetClick implements IToolBarWidgetClick {

    public static const ACTIVITY:String = "activity";


    private var _widget:ToolBarWidget;

    public function ActivityWidgetClick() {
        super();
    }

    public function onWidgetClick(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_5);
        this._widget.showNormal();
        ModuleManager.toggleModule(URLUtil.getAppModule("TimeNews"), "正在打开赛尔新闻...");
        this.writeRecord();
    }

    public function get widget():ToolBarWidget {
        return this._widget;
    }

    public function set widget(param1:ToolBarWidget):void {
        this._widget = param1;
        if (this.isReandNews() == false) {
            this._widget.alwaysShowNotice();
        }
    }

    private function isReandNews():Boolean {
        var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.SEER_NEWS_TAG);
        var _loc2_:String = String(_loc1_.data["news"]);
        if (_loc2_ == VersionManager.version) {
            return true;
        }
        return false;
    }

    private function writeRecord():void {
        var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.SEER_NEWS_TAG);
        _loc1_.data["news"] = VersionManager.version;
        _loc1_.flush();
    }
}
}
