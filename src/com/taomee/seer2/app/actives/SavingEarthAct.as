package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NumDisplayUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFormat;
import flash.utils.clearTimeout;

import org.taomee.utils.Tick;

public class SavingEarthAct {

    private static var _instance:SavingEarthAct;


    private var hero:MovieClip;

    private var justin:MovieClip;

    private var deviceMc:MovieClip;

    private var outId:uint;

    private var _pretime:uint;

    private var _useTimes:Array;

    private var needTime:int;

    private var _useCount:uint;

    private var timeTxt:Sprite;

    private var passTime:int;

    private var canCharge:Boolean;

    private var format:TextFormat;

    public function SavingEarthAct() {
        this._useTimes = [0, 60, 60, 120, 120];
        super();
    }

    public static function getInstance():SavingEarthAct {
        if (!_instance) {
            _instance = new SavingEarthAct();
        }
        return _instance;
    }

    private function lightNpc(param1:int):void {
        ++this.passTime;
        this.updateTxt();
        if (this.passTime >= this.needTime && !this.canCharge) {
            Tick.instance.removeRender(this.lightNpc);
            DisplayObjectUtil.removeFromParent(this.timeTxt);
            this.deviceMc.gotoAndStop(2);
        }
    }

    private function updateTxt():void {
        if (this.timeTxt) {
            DisplayObjectUtil.removeFromParent(this.timeTxt);
        }
        this.timeTxt = NumDisplayUtil.getNumDisplay(this.needTime - this.passTime, "UI_NumberCountDown", 28);
        this.timeTxt.x = 785;
        this.timeTxt.y = 230;
        SceneManager.active.mapModel.content.addChild(this.timeTxt);
    }

    public function dispose():void {
        if (this.outId != 0) {
            clearTimeout(this.outId);
        }
        ActorManager.showRemoteActor = true;
        Tick.instance.removeRender(this.checkTime);
        Tick.instance.removeRender(this.lightNpc);
        this.deviceMc.removeEventListener(MouseEvent.CLICK, this.showManhua);
        this.justin.removeEventListener(MouseEvent.CLICK, this.openPanel);
    }

    public function setup():void {
        this.initMobile();
        this.initRemove();
        this.canCharge = false;
        ActorManager.showRemoteActor = false;
        this.getNewData();
    }

    public function getNewData():void {
        this.canCharge = false;
        DayLimitManager.getDoCount(567, this.getActCount);
    }

    private function getActCount(param1:uint):void {
        this._useCount = param1;
        if (param1 == 0) {
            this.canCharge = true;
        }
        if (param1 < 5) {
            this.needTime = this._useTimes[param1];
        } else {
            this.needTime = 180;
        }
        DayLimitManager.getDoCount(566, this.getPreTime);
    }

    private function getPreTime(param1:uint):void {
        this._pretime = param1;
        this.update();
    }

    private function update():void {
        this.deviceMc.gotoAndStop(1);
        this.passTime = TimeManager.getServerTime() - this._pretime;
        if (this.passTime < 0) {
            this.passTime = 0;
        }
        if (this.passTime < this.needTime) {
            if (Tick.instance.hasRender(this.lightNpc)) {
                Tick.instance.removeRender(this.lightNpc);
            }
            this.updateTxt();
            Tick.instance.addRender(this.lightNpc, 1000);
        } else {
            DisplayObjectUtil.removeFromParent(this.timeTxt);
            this.deviceMc.gotoAndStop(2);
        }
    }

    private function initRemove():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc2_:Date = new Date(2012, 12, 21, 21);
        var _loc3_:Number = _loc2_.getTime() - _loc1_.getTime();
        if (_loc3_ < 0) {
            _loc3_ = 0;
        }
    }

    private function to70():void {
        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("JustinChargeOver"), function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        });
    }

    private function initMobile():void {
        this.hero = SceneManager.active.mapModel.content["hero"];
        this.hero.gotoAndStop(1);
        this.justin = this.hero["justin"];
        this.justin.mouseChildren = false;
        this.justin.buttonMode = true;
        this.justin.addEventListener(MouseEvent.CLICK, this.openPanel);
        this.deviceMc = SceneManager.active.mapModel.content["deviceMc"];
        this.deviceMc.gotoAndStop(1);
        this.deviceMc.buttonMode = true;
        this.deviceMc.addEventListener(MouseEvent.CLICK, this.showManhua);
        this.checkTime(0);
        Tick.instance.addRender(this.checkTime, 10000);
    }

    private function checkTime(param1:int):void {
        var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc2_.fullYear == 2012 && _loc2_.month == 11 && _loc2_.date == 21) {
            if (_loc2_.hours == 20 && _loc2_.minutes > 15) {
                this.hero.gotoAndStop(2);
                Tick.instance.removeRender(this.checkTime);
            }
        }
    }

    private function showManhua(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (this.deviceMc.currentFrame == 2) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("JustinChargeFull"), function ():void {
                ServerMessager.addMessage("能量充满了，赶快去帮助贾斯汀站长吧！");
                deviceMc.gotoAndStop(1);
                canCharge = true;
            }, false, false, 1, false);
        }
    }

    protected function openPanel(param1:MouseEvent):void {
        var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc3_:Date = new Date(2012, 12, 21, 20);
        var _loc4_:Date = new Date(2012, 12, 21, 21);
        if (_loc2_ >= _loc4_ && _loc2_ <= _loc3_) {
            this.to70();
            return;
        }
        if (this.canCharge) {
            ModuleManager.toggleModule(URLUtil.getAppModule("JustinChargePanel"));
        } else {
            AlertManager.showAlert("现在无法传送能量给站长！快用场景右侧的\n充能装置补充能量！");
        }
    }
}
}
