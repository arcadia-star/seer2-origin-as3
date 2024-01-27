package com.taomee.seer2.app.processor.activity.meteorShopTips {
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.controls.widget.BoxTipWidget;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class MeteorShopTipsAct {

    public static var initTime:Number;

    public static var overTime:Number;

    private static var _timer:Timer = new Timer(5000);

    private static var _mcTips:BoxTipWidget;


    public function MeteorShopTipsAct() {
        super();
    }

    public static function setup():void {
        TimeManager.addEventListener(TimeManager.TIME_UPDATE, onTreasureTimeUpdate);
        initTime = TimeManager.getServerTime();
        overTime = initTime + 680;
        _mcTips = ToolBar.getWidget(BoxTipWidget.BOX_TIP) as BoxTipWidget;
        _mcTips.visible = false;
        _mcTips.mainUI.gotoAndStop(18);
    }

    private static function onTreasureTimeUpdate(param1:Event):void {
        var nowTime:uint = 0;
        var event:Event = param1;
        if (SceneManager.active.type != SceneType.ARENA) {
            nowTime = uint(TimeManager.getServerTime());
            if (nowTime >= initTime + 600) {
                initTime = TimeManager.getServerTime();
                _mcTips.visible = true;
                _timer.addEventListener(TimerEvent.TIMER, showTips);
                _timer.start();
                overTime = nowTime + 60;
            }
            if (nowTime >= overTime) {
                _timer.stop();
                if (_mcTips.mainUI.currentFrame < 9) {
                    MovieClipUtil.playMc(_mcTips.mainUI, 10, 18, function ():void {
                        _mcTips.visible = false;
                    });
                } else {
                    _mcTips.visible = false;
                }
                overTime = nowTime + 680;
            }
        }
    }

    private static function showTips(param1:TimerEvent):void {
        var e:TimerEvent = param1;
        _timer.removeEventListener(TimerEvent.TIMER, showTips);
        MovieClipUtil.playMc(_mcTips.mainUI, 1, 8, function ():void {
            _timer.addEventListener(TimerEvent.TIMER, closeTips);
        });
    }

    private static function closeTips(param1:TimerEvent):void {
        var e:TimerEvent = param1;
        _timer.removeEventListener(TimerEvent.TIMER, closeTips);
        MovieClipUtil.playMc(_mcTips.mainUI, 10, 18, function ():void {
            _timer.addEventListener(TimerEvent.TIMER, showTips);
        });
    }
}
}
