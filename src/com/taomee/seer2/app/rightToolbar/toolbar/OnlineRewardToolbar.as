package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.activity.onlineControl.OnlineControl;
import com.taomee.seer2.app.activity.onlineReward.Nono1122Info;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.rightToolbar.RightToolbar;
import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.manager.EventManager;

public class OnlineRewardToolbar extends RightToolbar {


    private var _isVipReward:uint;

    private var _totalVipTime:uint;

    private var _whichStage:uint;

    private var _count:uint = 10000;

    private var _resideTime:uint;

    private var _resideLevel:uint;

    private var _dayGetList:Vector.<Boolean>;

    public function OnlineRewardToolbar() {
        this._dayGetList = Vector.<Boolean>([]);
        super();
    }

    override public function init(param1:RightToolbarInfo):void {
        super.init(param1);
        EventManager.addEventListener("SwapOnlineReward", this.onOnline);
        this.updateDayOnline();
    }

    private function onOnline(param1:Event):void {
        this.updateDayOnline();
    }

    private function updateDayOnline():void {
        DayLimitManager.getDoCount(900, function (param1:uint):void {
            _dayGetList[0] = (param1 & 1) == 1;
            _dayGetList[1] = (param1 & 2) == 2;
            _dayGetList[2] = (param1 & 4) == 4;
            _dayGetList[3] = (param1 & 8) == 8;
            _dayGetList[4] = (param1 & 16) == 16;
            _dayGetList[5] = (param1 & 32) == 32;
            _dayGetList[6] = (param1 & 64) == 64;
            setTime();
        });
    }

    private function setTime():void {
        this._resideLevel = OnlineControl.getOnlineLevel();
        var _loc1_:Boolean = true;
        var _loc2_:int = 0;
        while (_loc2_ < this._resideLevel) {
            if (this._dayGetList[_loc2_] == false) {
                _loc1_ = false;
                break;
            }
            _loc2_++;
        }
        if (_loc1_) {
            this._resideTime = OnlineControl.currGiftTime();
            setShowTime(true, this._resideTime);
        } else {
            setShowTime(false, 0);
            if (this._resideLevel != 0) {
                setShowTimeComplete(true);
            }
        }
        update();
    }

    private function onGetOnlineInfo(param1:IDataInput):void {
        this._isVipReward = param1.readUnsignedInt();
        this._totalVipTime = param1.readUnsignedInt();
        this._whichStage = param1.readUnsignedInt();
        this._count = param1.readUnsignedInt();
        this._resideTime = param1.readUnsignedInt();
        Nono1122Info.instance().isVipReward = this._isVipReward;
        Nono1122Info.instance().totalVipTime = this._totalVipTime;
        Nono1122Info.instance().whichStage = this._whichStage;
        Nono1122Info.instance().resideTime = this._resideTime;
        if (this._whichStage != 5 && this._resideTime <= 0) {
            setShowTimeComplete(true);
            update();
        }
        if (this._resideTime > 0) {
            setShowTime(true, this._resideTime);
            update();
        }
    }

    override protected function onClick(param1:MouseEvent):void {
        _isShowTimeComplete = false;
        removeTimeComplete();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_21);
        ModuleManager.showModule(URLUtil.getAppModule("OnlineRewardPanel"), "正在NONO在线领奖");
        SoundEffects.playSoundMouseClick();
    }
}
}
