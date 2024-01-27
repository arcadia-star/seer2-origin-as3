package com.taomee.seer2.app.activity.onlineReward {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.config.NonoNewsConfig;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.team.TeamManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class BigNonoNews {


    private var _rewardPanel:MovieClip;

    private var _news:MovieClip;

    private var _gotoMapBtn:SimpleButton;

    private var _timer:Timer;

    private var _nonoNewsInfoVec:Vector.<NonoNewsInfo>;

    private var _nonoNewsInfo:NonoNewsInfo;

    private var _currIndex:int;

    private const TOTAL_PAGE:int = 6;

    public function BigNonoNews(param1:MovieClip, param2:uint) {
        super();
        this._rewardPanel = param1;
        this._rewardPanel.visible = false;
        this._currIndex = param2;
        (this._rewardPanel["page_" + this._currIndex] as MovieClip).gotoAndStop("select");
        this._gotoMapBtn = this._rewardPanel["gotoMapBtn"];
        this._timer = new Timer(3000);
        this._nonoNewsInfoVec = NonoNewsConfig.getNonoNewsInfoVec();
        this._nonoNewsInfo = this._nonoNewsInfoVec[this._currIndex];
        this.initEvent();
    }

    private function initEvent():void {
        this._gotoMapBtn.addEventListener(MouseEvent.CLICK, this.onClick);
        this._timer.addEventListener(TimerEvent.TIMER, this.onMove);
        this._rewardPanel["closeBtn"].addEventListener(MouseEvent.CLICK, this.onClose);
        var _loc1_:int = 0;
        while (_loc1_ < this.TOTAL_PAGE) {
            (this._rewardPanel["page_" + _loc1_] as MovieClip).visible = false;
            (this._rewardPanel["page_" + _loc1_] as MovieClip).buttonMode = true;
            _loc1_++;
        }
    }

    public function moveStart():void {
        if (this._timer) {
            this._timer.start();
            this._timer.addEventListener(TimerEvent.TIMER, this.onMove);
        }
    }

    private function onClose(param1:MouseEvent):void {
        this._rewardPanel.visible = false;
    }

    public function showPanel(param1:uint = 0):void {
        if (param1 < this.TOTAL_PAGE) {
            this._currIndex = param1;
        } else {
            this._currIndex = this.TOTAL_PAGE - 1;
        }
        this._rewardPanel.visible = true;
        (this._rewardPanel["totalMC"] as MovieClip).gotoAndStop(this._currIndex + 1);
    }

    private function onOver(param1:MouseEvent):void {
        (this._rewardPanel["page_" + this._currIndex] as MovieClip).gotoAndStop("normal");
        this._currIndex = int((param1.currentTarget as MovieClip).name.split("_")[1]);
        (param1.currentTarget as MovieClip).gotoAndStop("select");
        (this._rewardPanel["totalMC"] as MovieClip).gotoAndStop(this._currIndex + 1);
        this._timer.stop();
    }

    private function onOut(param1:MouseEvent):void {
        this._timer.start();
    }

    private function onClick(param1:MouseEvent):void {
        var _loc2_:Array = null;
        var _loc3_:String = null;
        var _loc4_:Object = null;
        var _loc5_:Array = null;
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_22);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_352);
        ModuleManager.closeForName("OnlineReward");
        this._nonoNewsInfo = this._nonoNewsInfoVec[this._currIndex];
        if (this._nonoNewsInfo.type == "gotoMap") {
            this.changeMap(uint(this._nonoNewsInfo.transport));
        } else if (this._nonoNewsInfo.type == "module") {
            _loc2_ = this._nonoNewsInfo.transport.split("|");
            if (_loc2_.length < 2) {
                ModuleManager.toggleModule(URLUtil.getAppModule(_loc2_[0]), "正在打开面板...");
            } else {
                _loc3_ = String(_loc2_[1]);
                _loc4_ = new Object();
                _loc5_ = _loc3_.split(":");
                _loc4_[_loc5_[0]] = _loc5_[1];
                ModuleManager.toggleModule(URLUtil.getAppModule(_loc2_[0]), "正在打开面板...", _loc4_);
            }
        }
        this.dispose();
    }

    private function changeMap(param1:uint):void {
        if (param1 == 50000) {
            SceneManager.changeScene(SceneType.HOME, ActorManager.actorInfo.id);
        } else if (param1 == 60000) {
            if (TeamManager.teamId) {
                SceneManager.changeScene(SceneType.TEAM, TeamManager.teamId);
            } else {
                AlertManager.showAlert("需要先加入或创建战队，你可以到 <font color=\'#ffcc00\'>教官室</font> 了解详情");
            }
        } else if (param1 == 70000) {
            SceneManager.changeScene(SceneType.PLANT, ActorManager.actorInfo.id);
        } else if (param1 > 80000) {
            SceneManager.changeScene(SceneType.LOBBY, param1);
        } else {
            SceneManager.changeScene(SceneType.LOBBY, param1);
        }
    }

    private function onMove(param1:TimerEvent):void {
        (this._rewardPanel["page_" + this._currIndex] as MovieClip).gotoAndStop("normal");
        if (this._currIndex < this.TOTAL_PAGE - 1) {
            ++this._currIndex;
        } else {
            this._currIndex = 0;
        }
        (this._rewardPanel["page_" + this._currIndex] as MovieClip).gotoAndStop("select");
        this._nonoNewsInfo = this._nonoNewsInfoVec[this._currIndex];
        (this._rewardPanel["totalMC"] as MovieClip).gotoAndStop(this._currIndex + 1);
    }

    public function dispose():void {
        if (this._timer) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onMove);
        }
        (this._rewardPanel["page_" + this._currIndex] as MovieClip).gotoAndStop("normal");
        this._currIndex = 0;
        (this._rewardPanel["page_" + this._currIndex] as MovieClip).gotoAndStop("select");
        (this._rewardPanel["totalMC"] as MovieClip).gotoAndStop(this._currIndex + 1);
    }
}
}
