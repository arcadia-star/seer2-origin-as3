package com.taomee.seer2.app.activity.onlineReward.powerTree {
import com.taomee.seer2.app.config.TimeLimitConfig;
import com.taomee.seer2.app.dream.DreamManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.module.ModuleProxy;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.clearInterval;
import flash.utils.setInterval;

import org.taomee.utils.DisplayUtil;

public class PowerTreeManager {

    private static var _mc:MovieClip;

    public static var timerDown:CountDownTimer;

    private static var timeid:int;

    private static var timeEveryid:int;

    private static var currentTimeLine:int;

    private static var finishBool:Boolean;


    public function PowerTreeManager() {
        super();
    }

    public static function setup():void {
        var _loc1_:Date = new Date(2012, 3, 29, 0, 0, 0);
        var _loc2_:Date = new Date(2012, 3, 29, 15, 0, 0);
        var _loc3_:uint = uint(TimeManager.getServerTime());
        if (_loc1_.time < _loc3_ * 1000 && _loc3_ * 1000 < _loc2_.time) {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitchComplete);
            SceneManager.addEventListener(SceneEvent.SWITCH_START, onMapSwitchStart);
        }
    }

    private static function onMapSwitchStart(param1:SceneEvent):void {
        clean();
    }

    private static function onMapSwitchComplete(param1:SceneEvent):void {
        if (Boolean(SceneManager.active) && (SceneManager.active.type == SceneType.ARENA || DreamManager.isDreamMap() || SceneManager.active.type == SceneType.HOME || SceneManager.active.type == SceneType.TEAM)) {
            return;
        }
        var _loc2_:Date = new Date(2012, 3, 29, 0, 0, 0);
        var _loc3_:Date = new Date(2012, 3, 29, 15, 0, 0);
        var _loc4_:uint = uint(TimeManager.getServerTime());
        if (_mc) {
            if (_loc4_ * 1000 < _loc3_.time && !finishBool) {
                showMC();
            }
        } else if (_loc2_.time < _loc4_ * 1000 && _loc4_ * 1000 < _loc3_.time) {
            QueueLoader.load(URLUtil.getActivityAnimation("powerTreeIcon"), LoadType.SWF, onResLoaded);
        } else {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitchComplete);
            SceneManager.removeEventListener(SceneEvent.SWITCH_START, onMapSwitchStart);
        }
    }

    private static function onResLoaded(param1:ContentInfo):void {
        _mc = (param1.content as MovieClip)["mc_3"];
        _mc.x = 907;
        _mc.y = 337;
        _mc["TimerUI"].visible = false;
        TooltipManager.addCommonTip(_mc, "能源之树");
        showMC();
    }

    private static function getCurrentTimeLine():void {
        var _loc1_:uint = 0;
        while (_loc1_ < 12) {
            if (TimeLimitConfig.InLimitTime(_loc1_ + 17)) {
                if (currentTimeLine != _loc1_) {
                    currentTimeLine = _loc1_;
                    readyGetPresent();
                    return;
                }
            }
            _loc1_++;
        }
        isoutTime();
    }

    private static function isoutTime():void {
        var _loc1_:Date = new Date(2012, 3, 29, 14, 57, 0);
        var _loc2_:Date = new Date(2012, 3, 29, 15, 0, 0);
        var _loc3_:uint = uint(TimeManager.getServerTime());
        if (_loc3_ * 1000 > _loc2_.time) {
            clean();
        }
    }

    private static function clean():void {
        clearInterval(timeEveryid);
        clearInterval(timeid);
        DisplayUtil.removeForParent(_mc);
    }

    private static function canStartTimer():void {
        var _loc1_:Date = new Date(2012, 3, 29, 11, 52, 0);
        if (TimeManager.getServerTime() * 1000 < _loc1_.time) {
            return;
        }
        clearInterval(timeid);
        timeid = setInterval(StartTimer, 1000);
    }

    public static function getOne():void {
    }

    public static function finish():void {
        clearInterval(timeid);
        clearInterval(timeEveryid);
        finishBool = true;
        if (timerDown) {
            timerDown.destroy();
            timerDown = null;
        }
        DisplayUtil.removeForParent(_mc);
    }

    public static function readyGetPresent():void {
    }

    public static function canAddPower():Boolean {
        var _loc1_:Date = new Date(2012, 6, 22, 11, 57, 0);
        var _loc2_:Date = new Date(2012, 6, 22, 14, 57, 0);
        if (TimeManager.getServerTime() * 1000 < _loc1_.time) {
            return false;
        }
        if (TimeManager.getServerTime() * 1000 > _loc2_.time) {
            return false;
        }
        if (!timerDown || !timerDown._countdownTimer) {
            return true;
        }
        return false;
    }

    public static function resetTimer():void {
        clearInterval(timeid);
        timerDown = new CountDownTimer(_mc, 300);
    }

    private static function StartTimer():void {
        var _loc2_:uint = 0;
        var _loc3_:Date = null;
        var _loc4_:Date = null;
        var _loc5_:int = 0;
        var _loc1_:int = -1;
        if (TimeLimitConfig.InLimitTime(30)) {
            _loc1_ = 30;
        }
        if (_loc1_ > 0) {
            _loc2_ = uint(TimeManager.getServerTime());
            _loc3_ = new Date(_loc2_ * 1000);
            if (_loc4_ = TimeLimitConfig.getEndDate(_loc1_)) {
                _loc5_ = (_loc4_.time - _loc3_.time) / 1000;
                if (!timerDown && _loc5_ > 0 && _loc5_ < 300) {
                    clearInterval(timeid);
                    _mc["TimerUI"].visible = true;
                    timerDown = new CountDownTimer(_mc, _loc5_);
                } else {
                    _mc["TimerUI"].visible = false;
                }
            }
        } else if (!inTreeGame()) {
            _mc["TimerUI"].visible = false;
        }
    }

    private static function inTreeGame():Boolean {
        var _loc1_:uint = 0;
        while (_loc1_ < 13) {
            if (TimeLimitConfig.InLimitTime(_loc1_ + 17)) {
                return true;
            }
            _loc1_++;
        }
        return false;
    }

    private static function showMC():void {
        if (!finishBool) {
            LayerManager.uiLayer.addChild(_mc);
            _mc.addEventListener(MouseEvent.CLICK, onClick);
            canStartTimer();
            timeid = setInterval(canStartTimer, 10000);
            timeEveryid = setInterval(getCurrentTimeLine, 5000);
            currentTimeLine = -1;
            _mc.useHandCursor = true;
            _mc.buttonMode = true;
        }
    }

    private static function onClick(param1:MouseEvent = null):void {
        var _loc2_:ModuleProxy = null;
        if (!param1) {
            _loc2_ = ModuleManager.getModule("PowerTreePanel");
            if (!_loc2_) {
                ModuleManager.toggleModule(URLUtil.getAppModule("PowerTreePanel"), "正在能源树面板...");
            }
        } else {
            ModuleManager.toggleModule(URLUtil.getAppModule("PowerTreePanel"), "正在能源树面板...");
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_63);
        }
    }
}
}
