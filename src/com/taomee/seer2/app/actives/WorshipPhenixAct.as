package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.Module;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.events.SyncEvent;
import flash.utils.getTimer;

public class WorshipPhenixAct {

    private static var _instance:WorshipPhenixAct;


    private var maps:Array;

    private var preTimes:Array;

    private var positions:Array;

    private var currentIndex:int = -1;

    private var needTime:uint = 600000;

    private var stoneCup:Mobile;

    private var module:Module;

    private var flyMc:MovieClip;

    public function WorshipPhenixAct() {
        this.maps = [90, 124, 142, 141, 160, 204, 202, 211, 230, 261, 281, 302];
        this.preTimes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        this.positions = [{
            "x": 390,
            "y": 280
        }, {
            "x": 700,
            "y": 415
        }, {
            "x": 310,
            "y": 300
        }, {
            "x": 795,
            "y": 245
        }, {
            "x": 210,
            "y": 320
        }, {
            "x": 755,
            "y": 290
        }, {
            "x": 170,
            "y": 290
        }, {
            "x": 580,
            "y": 390
        }, {
            "x": 220,
            "y": 400
        }, {
            "x": 610,
            "y": 430
        }, {
            "x": 580,
            "y": 390
        }, {
            "x": 226,
            "y": 323
        }];
        super();
    }

    public static function getInstance():WorshipPhenixAct {
        if (!_instance) {
            _instance = new WorshipPhenixAct();
        }
        return _instance;
    }

    public function setup():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.fullYear == 2012 && _loc1_.month == 10 && _loc1_.date >= 23 && _loc1_.date < 26) {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
        }
    }

    private function onComplete(param1:SceneEvent):void {
        this.clearListener();
        var _loc2_:int = int(SceneManager.active.mapID);
        this.currentIndex = this.maps.indexOf(_loc2_);
        if (this.currentIndex == -1) {
            return;
        }
        this.createStoneCup();
    }

    private function clearListener():void {
        if (this.module) {
            this.module.removeEventListener("swapComplete", this.onSwapComplete);
        }
        if (this.stoneCup) {
            this.stoneCup.removeEventListener(MouseEvent.CLICK, this.clickStone);
        }
    }

    private function createStoneCup():void {
        if (!this.stoneCup) {
            this.stoneCup = new Mobile();
        }
        this.stoneCup.x = this.positions[this.currentIndex].x;
        this.stoneCup.y = this.positions[this.currentIndex].y;
        this.stoneCup.buttonMode = true;
        this.stoneCup.mouseChildren = false;
        this.stoneCup.resourceUrl = URLUtil.getNpcSwf(175);
        this.stoneCup.addEventListener(MouseEvent.CLICK, this.clickStone);
        MobileManager.addMobile(this.stoneCup, MobileType.NPC);
        TooltipManager.remove(this.stoneCup);
        TooltipManager.addCommonTip(this.stoneCup, "朝拜凤凰神");
    }

    private function clickStone(param1:MouseEvent):void {
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc2_:int = getTimer();
        var _loc3_:int = _loc2_ - this.preTimes[this.currentIndex];
        if (_loc3_ >= this.needTime || _loc2_ == _loc3_) {
            ModuleManager.toggleModule(URLUtil.getAppModule("WordshipPhenixPanel"));
            ModuleManager.addEventListener("WordshipPhenixPanel", ModuleEvent.SHOW, this.showComplete);
        } else if (_loc3_ < this.needTime) {
            _loc5_ = (_loc4_ = int((this.needTime - _loc3_) / 1000)) / 60;
            _loc6_ = _loc4_ % 60;
            AlertManager.showAlert("你已经朝拜过一次了，离下次朝拜还有" + _loc5_ + "分" + _loc6_ + "秒!");
        }
    }

    private function showComplete(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("WordshipPhenixPanel", ModuleEvent.SHOW, this.showComplete);
        this.module = ModuleManager.getModule("WordshipPhenixPanel").module;
        this.module.addEventListener("swapComplete", this.onSwapComplete);
    }

    private function onSwapComplete(param1:SyncEvent):void {
        (param1.target as Module).removeEventListener("swapComplete", this.onSwapComplete);
        this.preTimes[this.currentIndex] = getTimer();
        this.playAnimation();
    }

    private function playAnimation():void {
        if (!this.flyMc) {
            QueueLoader.load(URLUtil.getActivityAnimation("PhinexFly"), LoadType.SWF, this.onLoadComplete);
        } else {
            this.toPlay();
        }
    }

    private function toPlay():void {
        this.flyMc.x = this.stoneCup.x;
        this.flyMc.y = this.stoneCup.y - 60;
        SceneManager.active.mapModel.front.addChild(this.flyMc);
        this.stoneCup.visible = false;
        MovieClipUtil.playMc(this.flyMc, 1, this.flyMc.totalFrames, function ():void {
            flyMc.gotoAndStop(1);
            DisplayObjectUtil.removeFromParent(flyMc);
            stoneCup.visible = true;
        }, true);
    }

    private function onLoadComplete(param1:ContentInfo):void {
        this.flyMc = param1.content as MovieClip;
        this.toPlay();
    }
}
}
