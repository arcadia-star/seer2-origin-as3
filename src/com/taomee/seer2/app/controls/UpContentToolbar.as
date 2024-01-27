package com.taomee.seer2.app.controls {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class UpContentToolbar extends Sprite {

    private static var _instance:UpContentToolbar;


    private var _mainPanel:MovieClip;

    private var _newsBtn:SimpleButton;

    private var _onlineBtn:MovieClip;

    private var _onlineReward:OnlineReward;

    private var _hotBtn:MovieClip;

    private var _activityMC:MovieClip;

    private var _isShowPage:Boolean;

    public function UpContentToolbar() {
        super();
        this._mainPanel = UIManager.getMovieClip("UI_Toolbar_UpContent");
        addChild(this._mainPanel);
        this._newsBtn = this._mainPanel["newsBtn"];
        this._hotBtn = this._mainPanel["activity"];
        this._onlineReward = new OnlineReward(this._mainPanel["onlineReward"]);
        addChild(this._onlineReward);
        this._isShowPage = false;
        this.addTip();
        this.updatePage();
        this.initEvent();
    }

    private static function get instance():UpContentToolbar {
        return null;
    }

    public static function show():void {
    }

    public static function hide():void {
    }

    private function addTip():void {
        TooltipManager.addCommonTip(this._newsBtn, "赛尔新闻");
        TooltipManager.addCommonTip(this._hotBtn, "精彩活动乐翻天");
    }

    private function initEvent():void {
        this._newsBtn.addEventListener(MouseEvent.CLICK, this.onNews);
        this._hotBtn.addEventListener(MouseEvent.CLICK, this.onHot);
    }

    private function onLineBtn(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule(""), "正在打开在线领奖面板...");
    }

    private function onOut(param1:MouseEvent):void {
        this.onHide(null);
    }

    private function onHide(param1:ToolbarEvent):void {
        this._isShowPage = false;
        this.updatePage();
    }

    private function onChange(param1:ToolbarEvent):void {
        if (param1.typeStr != "Activity" && param1.status) {
            this._isShowPage = false;
            this.updatePage();
        }
    }

    private function onNews(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("TimeNews"), "正在打开赛尔新闻...");
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_317);
    }

    private function onActivity(param1:MouseEvent):void {
        this._isShowPage = !this._isShowPage;
        ToolbarEventDispatcher.dispatchEvent(new ToolbarEvent(ToolbarEvent.PAGE_CHANGE, this._isShowPage, "Activity"));
        this.updatePage();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_318);
    }

    private function onHot(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("NoticePanel"), "正在打开赛尔新闻...");
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_336);
    }

    private function onDay(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("ActCalendarPanel"), "正在打开赛尔新闻...");
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_337);
    }

    private function updatePage():void {
        if (this._isShowPage == false) {
        }
    }

    public function show():void {
        LayerManager.uiLayer.addChild(this);
    }

    public function hide():void {
        DisplayObjectUtil.removeFromParent(this);
    }
}
}
