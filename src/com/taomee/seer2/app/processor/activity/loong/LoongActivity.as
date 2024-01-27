package com.taomee.seer2.app.processor.activity.loong {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class LoongActivity {


    private var _map:MapModel;

    private var _box:SimpleButton;

    public function LoongActivity(param1:MapModel) {
        super();
        this._map = param1;
        this._box = this._map.content["box"];
        this.initBoxStatus();
        this.initEvent();
    }

    public static function isActivityTime():Boolean {
        var _loc1_:uint = new Date(2012, 0, 20, 14, 30).getTime() / 1000;
        var _loc2_:uint = new Date(2012, 0, 20, 15, 30).getTime() / 1000;
        if (TimeManager.getServerTime() < _loc2_ && TimeManager.getServerTime() > _loc1_) {
            return true;
        }
        return false;
    }

    public static function isTimePrev():Boolean {
        var _loc1_:uint = new Date(2012, 0, 20, 14, 30).getTime() / 1000;
        if (TimeManager.getServerTime() < _loc1_) {
            return true;
        }
        return false;
    }

    private function initBoxStatus():void {
        if (this.isTimeContent()) {
            this._box.visible = true;
            TooltipManager.addCommonTip(this._box, "光伊特的神秘礼盒");
        } else {
            this._box.visible = false;
        }
    }

    private function initEvent():void {
        this._box.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (this.isTimeContent()) {
            ModuleManager.toggleModule(URLUtil.getAppModule("LoongPanel"), "正在打开春节面板...");
        } else {
            AlertManager.showAlert("光伊特设定的时间过啦，神秘的箱子已经消失喽！", function ():void {
                _box.visible = false;
            });
        }
    }

    private function isTimeContent():Boolean {
        var _loc1_:uint = new Date(2012, 0, 20, 15, 30).getTime() / 1000;
        if (TimeManager.getServerTime() > _loc1_) {
            return false;
        }
        return true;
    }

    public function dispose():void {
        if (this._box != null) {
            this._box.removeEventListener(MouseEvent.CLICK, this.onClick);
            TooltipManager.remove(this._box);
        }
        this._box = null;
    }
}
}
