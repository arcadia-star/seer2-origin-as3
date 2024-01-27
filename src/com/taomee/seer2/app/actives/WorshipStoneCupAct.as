package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_57;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class WorshipStoneCupAct {

    private static var _instance:WorshipStoneCupAct;


    private const maps:Array = [90, 124, 142, 141, 160, 204, 202, 211, 230, 261, 281, 302];

    private const positions:Array = [{
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

    private const stoneTips:String = "朝拜月神";

    private const coolingTime:int = 600;

    private const startDate:Date = new Date(2013, 3, 3);

    private const endDate:Date = new Date(2013, 3, 7);

    private const preTimeID:Array = [202200, 202201, 202202, 202203, 202204, 202205, 202206, 202207, 202208, 202209, 202210, 202211];

    private var currentIndex:int;

    private var stoneCup:Mobile;

    private var preTime:uint;

    public function WorshipStoneCupAct() {
        super();
    }

    public static function getInstance():WorshipStoneCupAct {
        if (!_instance) {
            _instance = new WorshipStoneCupAct();
        }
        return _instance;
    }

    public function setup():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_ > this.startDate && _loc1_ < this.endDate) {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
        }
    }

    private function onComplete(param1:SceneEvent):void {
        var _loc2_:int = int(SceneManager.active.mapID);
        this.currentIndex = this.maps.indexOf(_loc2_);
        if (this.currentIndex == -1) {
            return;
        }
        this.createStoneCup();
    }

    private function createStoneCup():void {
        if (!this.stoneCup) {
            this.stoneCup = new Mobile();
            this.stoneCup.buttonMode = true;
            this.stoneCup.mouseChildren = false;
            this.stoneCup.id = 175;
            TooltipManager.addCommonTip(this.stoneCup, this.stoneTips);
        }
        this.stoneCup.resourceUrl = URLUtil.getNpcSwf(175);
        this.stoneCup.addEventListener(MouseEvent.CLICK, this.clickStone);
        this.stoneCup.x = this.positions[this.currentIndex].x;
        this.stoneCup.y = this.positions[this.currentIndex].y;
        MobileManager.addMobile(this.stoneCup, MobileType.NPC);
    }

    private function clickStone(param1:MouseEvent):void {
        ActiveCountManager.requestActiveCount(this.preTimeID[this.currentIndex], this.getWorshipState);
    }

    private function getWorshipState(param1:int, param2:uint):void {
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        this.preTime = param2;
        var _loc3_:Number = TimeManager.getServerTime() - this.preTime;
        if (_loc3_ < this.coolingTime) {
            _loc5_ = (_loc4_ = this.coolingTime - _loc3_) / 60;
            _loc6_ = _loc4_ % 60;
            AlertManager.showAlert("你已经朝拜过一次了，离下次朝拜还有" + _loc5_ + "分" + _loc6_ + "秒!");
            return;
        }
        ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_57, this.getBuffer);
    }

    private function getBuffer(param1:ServerBuffer):void {
        var buffer:ServerBuffer = param1;
        var state:int = buffer.readDataAtPostion(ServerBufferPosition_57.IS_PLAY_WORSHIP_MOON);
        if (state == 0) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("MoonStoryFull"), function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("WorshipStoneCupPanel"));
                ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_57, ServerBufferPosition_57.IS_PLAY_WORSHIP_MOON, 1);
            }, true, true);
        } else {
            ModuleManager.toggleModule(URLUtil.getAppModule("WorshipStoneCupPanel"));
        }
    }
}
}
