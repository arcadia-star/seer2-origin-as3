package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.rightToolbar.RightToolbar;
import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;

import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.manager.EventManager;

public class NewYearGetMiToolbar extends RightToolbar {


    public function NewYearGetMiToolbar() {
        super();
    }

    override public function init(param1:RightToolbarInfo):void {
        super.init(param1);
        EventManager.addEventListener("NewYearGetMi", this.onUpdateState);
        this.updateTimeState();
    }

    private function onUpdateState(param1:Event):void {
        this.updateTimeState();
    }

    private function updateTimeState():void {
        DayLimitListManager.getDaylimitList([1853, 1854], function (param1:DayLimitListInfo):void {
            var _loc2_:int = 0;
            if (param1.getCount(1853) >= 10) {
                _isShowTimeComplete = false;
                removeTimeComplete();
                setShowTime(false, 0);
            } else {
                _loc2_ = param1.getCount(1854) - TimeManager.getPrecisionServerTime();
                if (_loc2_ > 0) {
                    setShowTime(true, _loc2_);
                } else {
                    setShowTime(false, 0);
                    setShowTimeComplete(true);
                }
            }
            update();
        });
    }

    override protected function onClick(param1:MouseEvent):void {
        _isShowTimeComplete = false;
        removeTimeComplete();
        ModuleManager.showAppModule("NewYearGetMiPanel");
        SoundEffects.playSoundMouseClick();
    }
}
}
