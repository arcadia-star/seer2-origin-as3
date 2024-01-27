package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.rightToolbar.RightToolbar;
import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.manager.EventManager;

public class CallBoxToolbar extends RightToolbar {


    private const STONE_CD:uint = 600;

    private const PALAEOID_CD:uint = 172800;

    private var preStoneTime:uint;

    private var leftFreeCount:uint;

    private var leftPalaeoidTime:uint;

    private var leftStoneTime:uint;

    private var palaeoidPreTime:uint;

    private var buyStoneNum:uint;

    private var buyPalaeoidNum:uint;

    private var maxCount:uint;

    public function CallBoxToolbar() {
        super();
    }

    override public function init(param1:RightToolbarInfo):void {
        super.init(param1);
        EventManager.addEventListener("CallBoxToolbarEvent", this.updateTwoYear);
        this.updateTwoYear();
    }

    private function updateTwoYear(param1:Event = null):void {
        ActiveCountManager.requestActiveCountList([204243, 204241], this.getSeverInfo);
    }

    private function getDayData(param1:DayLimitListInfo):void {
        this.preStoneTime = param1.getCount(1143);
        var _loc2_:int = TimeManager.getPrecisionServerTime() - this.preStoneTime;
        this.leftStoneTime = this.STONE_CD - _loc2_ > 0 ? uint(this.STONE_CD - _loc2_) : 0;
        if (VipManager.vipInfo.isVip()) {
            this.leftFreeCount = ActsHelperUtil.getCanNum(param1.getCount(1142), this.buyStoneNum, 3);
            this.maxCount = 3;
        } else {
            this.leftFreeCount = ActsHelperUtil.getCanNum(param1.getCount(1142), this.buyStoneNum, 1);
            this.maxCount = 1;
        }
        if (this.leftStoneTime <= 0 && this.leftFreeCount > 0) {
            setShowTime(false, 0);
            setShowTimeComplete(true);
        } else if (this.leftStoneTime > 0) {
            setShowTime(true, this.leftStoneTime);
        } else if (this.leftPalaeoidTime == 0) {
            setShowTime(false, 0);
            setShowTimeComplete(true);
        } else {
            setShowTime(false, 0);
        }
        update();
    }

    private function getSeverInfo(param1:Parser_1142):void {
        var _loc2_:int = 0;
        this.palaeoidPreTime = param1.infoVec[0];
        this.buyStoneNum = param1.infoVec[1];
        if (this.palaeoidPreTime != 0) {
            _loc2_ = TimeManager.getPrecisionServerTime() - this.palaeoidPreTime;
            this.leftPalaeoidTime = this.PALAEOID_CD - _loc2_ > 0 ? uint(this.PALAEOID_CD - _loc2_) : 0;
        }
        DayLimitListManager.getDaylimitList([1143, 1142], this.getDayData);
    }

    override protected function onClick(param1:MouseEvent):void {
        _isShowTimeComplete = false;
        removeTimeComplete();
        ModuleManager.showModule(URLUtil.getAppModule("CallBoxPanel"), "正在");
        SoundEffects.playSoundMouseClick();
    }
}
}
