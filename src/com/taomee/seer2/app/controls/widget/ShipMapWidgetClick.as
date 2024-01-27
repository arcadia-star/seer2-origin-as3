package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.map.MapCategory;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.module.ModuleProxy;
import com.taomee.seer2.core.scene.BaseScene;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class ShipMapWidgetClick implements IToolBarWidgetClick {

    public static const SHIP_MAP:String = "shipmap";


    private var _widget:ToolBarWidget;

    public function ShipMapWidgetClick() {
        super();
    }

    public function get widget():ToolBarWidget {
        return this._widget;
    }

    public function set widget(param1:ToolBarWidget):void {
        this._widget = param1;
    }

    public function onWidgetClick(param1:MouseEvent):void {
        var _loc3_:Object = null;
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_4);
        var _loc2_:BaseScene = SceneManager.active;
        if (_loc2_.mapCategoryID == MapCategory.WIND) {
            AlertManager.showAlert("正在探索中...");
            return;
        }
        if (ModuleManager.getModuleStatus("MapPanel") == ModuleProxy.SHOW) {
            ModuleManager.closeForName("MapPanel");
        }
        if (_loc2_.mapCategoryID == MapCategory.STRONGHOLD) {
            if (ModuleManager.getModuleStatus("ShipMap2Panel") == ModuleProxy.SHOW) {
                ModuleManager.closeForName("ShipMap2Panel");
            }
            if (ModuleManager.getModuleStatus("MapSignPanel") == ModuleProxy.SHOW) {
                ModuleManager.closeForName("MapSignPanel");
            }
            ModuleManager.toggleModule(URLUtil.getAppModule("DoorMapPanel"), "正在打开英格瓦要塞……");
        } else if (_loc2_.mapCategoryID == MapCategory.SHIP) {
            if (ModuleManager.getModuleStatus("DoorMapPanel") == ModuleProxy.SHOW) {
                ModuleManager.closeForName("DoorMapPanel");
            }
            if (ModuleManager.getModuleStatus("MapSignPanel") == ModuleProxy.SHOW) {
                ModuleManager.closeForName("MapSignPanel");
            }
            _loc3_ = new Object();
            _loc3_["mapCategoryId"] = _loc2_.mapCategoryID;
            _loc3_["mapId"] = _loc2_.mapID;
            ModuleManager.toggleModule(URLUtil.getAppModule("ShipMap2Panel"), "正在打开地图导航...", _loc3_);
        } else {
            if (ModuleManager.getModuleStatus("ShipMap2Panel") == ModuleProxy.SHOW) {
                ModuleManager.closeForName("ShipMap2Panel");
            }
            if (ModuleManager.getModuleStatus("DoorMapPanel") == ModuleProxy.SHOW) {
                ModuleManager.closeForName("DoorMapPanel");
            }
            ModuleManager.toggleModule(URLUtil.getAppModule("MapSignPanel"), "正在打开地图指示模块...", {"categoryId": _loc2_.mapCategoryID});
        }
    }
}
}
