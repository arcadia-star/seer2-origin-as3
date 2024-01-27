package com.taomee.seer2.app.controls {
import com.taomee.seer2.app.activity.onlineControl.OnlineControl;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.taomee.utils.Tick;

public class OnlineReward extends Sprite {


    private var _mainUI:MovieClip;

    private var _timeComplete:MovieClip;

    private var _timeMC:MovieClip;

    private var _btn:SimpleButton;

    private var _icon:MovieClip;

    private var _isShowTimeComplete:Boolean;

    private var _isVipReward:uint;

    private var _totalVipTime:uint;

    private var _whichStage:uint;

    private var _count:uint = 10000;

    private var _resideTime:uint;

    private var _timeCount:uint;

    private var _isShowTime:Boolean;

    private var _isShowLift:Boolean;

    private var _dayGetList:Vector.<Boolean>;

    private const ONLINE_TIME_ARR:Array = [300, 600, 900, 1200, 2400, 3600, 5400];

    private var _preLevel:int;

    public function OnlineReward(param1:MovieClip) {
        super();
        this._mainUI = param1;
        this._icon = this._mainUI["icon"];
        this._icon.mouseEnabled = false;
        this._btn = this._mainUI["btn"];
        addChild(param1);
        this.setTime();
        TooltipManager.addCommonTip(this._mainUI, "NONO在线领奖");
        this._btn.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function setTime():void {
        this.onHideModule(null);
        ModuleManager.addEventListener("OnlineRewardPanel", ModuleEvent.HIDE, this.onHideModule);
    }

    private function onHideModule(param1:ModuleEvent):void {
        var event:ModuleEvent = param1;
        this._dayGetList = Vector.<Boolean>([]);
        DayLimitManager.getDoCount(900, function (param1:uint):void {
            _dayGetList[0] = (param1 & 1) == 1;
            _dayGetList[1] = (param1 & 2) == 2;
            _dayGetList[2] = (param1 & 4) == 4;
            _dayGetList[3] = (param1 & 8) == 8;
            _dayGetList[4] = (param1 & 16) == 16;
            _dayGetList[5] = (param1 & 32) == 32;
            _dayGetList[6] = (param1 & 64) == 64;
            var _loc2_:Boolean = false;
            var _loc3_:int = 0;
            while (_loc3_ < 7) {
                if (_dayGetList[_loc3_] == false && OnlineControl.getOnlineLevel() > _loc3_) {
                    _loc2_ = true;
                }
                _loc3_++;
            }
            if (_loc2_) {
                _icon.gotoAndStop(2);
                removeTime();
            } else {
                _icon.gotoAndStop(1);
                if (OnlineControl.getOnlineLevel() >= 7) {
                    removeTime();
                } else {
                    _timeCount = ONLINE_TIME_ARR[OnlineControl.getOnlineLevel()] - TimeManager.getOnlineTime();
                    removeTime();
                    showTime();
                }
            }
        });
    }

    private function showTime():void {
        if (!this._timeMC) {
            this._timeMC = UIManager.getMovieClip("UI_Right_Time");
            this.updateTime();
        } else {
            this.updateTime();
        }
    }

    private function updateTime():void {
        this._timeMC.x = 115;
        this._timeMC.y = 46;
        addChild(this._timeMC);
        Tick.instance.addRender(this.updateTimeMC, 1000);
        this.updateTimeMC(1111);
    }

    public function update():void {
        this.onHideModule(null);
    }

    private function onClick(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("OnlineRewardPanel"), "正在NONO在线领奖");
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_422);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_510);
    }

    private function updateTimeMC(param1:uint):void {
        if (this._preLevel != OnlineControl.getOnlineLevel()) {
            this._preLevel = OnlineControl.getOnlineLevel();
            this.onHideModule(null);
        }
        this._timeCount = this.ONLINE_TIME_ARR[OnlineControl.getOnlineLevel()] - TimeManager.getOnlineTime();
        var _loc2_:uint = this._timeCount / 60;
        var _loc3_:uint = this._timeCount % 60;
        (this._timeMC["mcMinDecade"] as MovieClip).gotoAndStop(uint(_loc2_ / 10) + 1);
        (this._timeMC["mcMinUnit"] as MovieClip).gotoAndStop(uint(_loc2_ % 10) + 1);
        (this._timeMC["mcSecDecade"] as MovieClip).gotoAndStop(uint(_loc3_ / 10) + 1);
        (this._timeMC["mcSecUnit"] as MovieClip).gotoAndStop(uint(_loc3_ % 10) + 1);
    }

    private function removeTime():void {
        if (Boolean(this._timeMC) && Boolean(this._timeMC.parent)) {
            this._timeMC.parent.removeChild(this._timeMC);
        }
        Tick.instance.removeRender(this.updateTimeMC);
    }
}
}
