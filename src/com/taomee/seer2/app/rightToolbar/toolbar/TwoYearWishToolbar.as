package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.rightToolbar.RightToolbar;
import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.manager.EventManager;
import org.taomee.utils.BitUtil;

public class TwoYearWishToolbar extends RightToolbar {


    private var wishType:uint;

    private var startTime:uint;

    private var currentType:int;

    private var needTime:int;

    private var overTime:int;

    private var leftTime:int;

    private const needTimes:Array = [10 * 60, 30 * 60, 15 * 60, 20 * 60, 10 * 60, 10 * 60, 10 * 60];

    public function TwoYearWishToolbar() {
        super();
    }

    override public function init(param1:RightToolbarInfo):void {
        super.init(param1);
        EventManager.addEventListener("TwoYearWishEvent", this.updateTwoYear);
        this.updateTwoYear();
    }

    private function updateTwoYear(param1:Event = null):void {
        ActiveCountManager.requestActiveCountList([203364, 203365], this.getSeverInfo);
    }

    private function getSeverInfo(param1:Parser_1142):void {
        this.wishType = param1.infoVec[0];
        this.startTime = param1.infoVec[1];
        this.currentType = -1;
        var _loc2_:int = 0;
        while (_loc2_ < 7) {
            if (BitUtil.getBit(this.wishType, _loc2_)) {
                this.currentType = _loc2_;
                break;
            }
            _loc2_++;
        }
        if (this.currentType != -1) {
            this.needTime = this.needTimes[this.currentType];
            this.overTime = TimeManager.getPrecisionServerTime() - this.startTime;
            this.leftTime = this.needTime - this.overTime;
            this.leftTime = this.leftTime > 0 ? this.leftTime : 0;
            if (this.overTime >= this.needTime) {
                setShowTime(false, 0);
                setShowTimeComplete(true);
            } else {
                setShowTime(true, this.leftTime);
            }
        } else {
            setShowTime(false, 0);
        }
        update();
    }

    override protected function onClick(param1:MouseEvent):void {
        _isShowTimeComplete = false;
        removeTimeComplete();
        ModuleManager.showModule(URLUtil.getAppModule("TwoYearWishPanel"), "正在NONO在线领奖");
        SoundEffects.playSoundMouseClick();
    }
}
}
