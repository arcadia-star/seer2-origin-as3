package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.info.BuyPropInfo;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.system.ApplicationDomain;
import flash.text.TextField;
import flash.utils.Timer;

import org.taomee.utils.DomainUtil;

public class MapLayerGame {

    private static const lastLayerCompleteTimeLimitId:int = 203299;

    private static const timeBetweenLayers:Array = [0, 5, 10, 20, 30, 24 * 60];

    private static const currentLayerLimitId:int = 203300;

    private static const mapId:Array = [8600, 8601, 8602, 8603, 8604, 8605];


    private var _mapModel:MapModel;

    private var _resLibs:ApplicationDomain;

    private var _loadCom:Boolean = false;

    private var _lastTime:uint;

    private var _timeLeftCount:int;

    private var _currentLayer:int;

    private var _timer:Timer;

    private var _leftTimeTxt:TextField;

    private var _leftTimeContainer:DisplayObject;

    private var _skipTimeBtn:SimpleButton;

    private var _popMc:DisplayObject;

    private var _canEnter:Boolean;

    private var shi:int;

    private var fen:int;

    private var miao:int;

    public function MapLayerGame(param1:MapModel) {
        super();
        this._mapModel = param1;
        this.init();
    }

    public function dispose():void {
        if (this._popMc) {
            this._popMc.removeEventListener(MouseEvent.CLICK, this.onPop);
            DisplayObjectUtil.removeFromParent(this._popMc);
        }
        if (this._timer) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._timer = null;
        }
        if (this._skipTimeBtn) {
            this._skipTimeBtn.removeEventListener(MouseEvent.CLICK, this.onSkip);
            DisplayObjectUtil.removeFromParent(this._skipTimeBtn);
        }
        if (this._leftTimeContainer) {
            DisplayObjectUtil.removeFromParent(this._leftTimeContainer);
        }
    }

    private function init():void {
        QueueLoader.load(URLUtil.getActivityAnimation("mapLayerGame/MapLayerGame"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLibs = param1.domain;
            _loadCom = true;
            initMap();
        });
    }

    private function initMap():void {
        this._popMc = this.getMovie("PopMc");
        this._mapModel.content.addChild(this._popMc);
        this._popMc.x = 300 + 337;
        this._popMc.y = 50 + 135;
        this._popMc.addEventListener(MouseEvent.CLICK, this.onPop);
        ActiveCountManager.requestActiveCountList([lastLayerCompleteTimeLimitId, currentLayerLimitId], function (param1:Parser_1142):void {
            _lastTime = param1.infoVec[0];
            _currentLayer = param1.infoVec[1];
            checkTime();
        });
    }

    private function onPop(param1:MouseEvent):void {
        if (this._canEnter == false) {
            AlertManager.showAlert("倒计时结束方可进入");
        } else {
            SceneManager.changeScene(SceneType.LOBBY, mapId[this._currentLayer]);
        }
    }

    private function checkTime():void {
        if (this._lastTime == 0) {
            this._canEnter = true;
        } else {
            this._timeLeftCount = this._lastTime + timeBetweenLayers[this._currentLayer] * 60 + 15 - TimeManager.getServerTime();
            if (this._timeLeftCount <= 0) {
                this._canEnter = true;
                this.removeTxtAndBtn();
            } else {
                this.addTxtAndBtn();
                this.startTimer();
            }
        }
    }

    private function addTxtAndBtn():void {
        this._leftTimeContainer = this.getMovie("Container");
        this._mapModel.content.addChild(this._leftTimeContainer);
        this._leftTimeContainer.x = 20 + 50;
        this._leftTimeContainer.y = 250;
        this._leftTimeTxt = this._leftTimeContainer["leftTxt"];
        this._leftTimeTxt.text = "";
        this._skipTimeBtn = this.getMovie("skipTimeBtn") as SimpleButton;
        this._mapModel.content.addChild(this._skipTimeBtn);
        this._skipTimeBtn.x = 100;
        this._skipTimeBtn.y = 200;
        this._skipTimeBtn.addEventListener(MouseEvent.CLICK, this.onSkip);
    }

    private function removeTxtAndBtn():void {
        if (this._leftTimeContainer) {
            DisplayObjectUtil.removeFromParent(this._leftTimeContainer);
        }
        if (this._skipTimeBtn) {
            DisplayObjectUtil.removeFromParent(this._skipTimeBtn);
            this._skipTimeBtn.removeEventListener(MouseEvent.CLICK, this.onSkip);
        }
    }

    private function onSkip(param1:MouseEvent):void {
        var _loc2_:BuyPropInfo = new BuyPropInfo();
        _loc2_.itemId = 603327;
        _loc2_.buyComplete = this.buyComplete;
        ShopManager.buyVirtualItem(_loc2_);
    }

    private function buyComplete(param1:Object):void {
        this._canEnter = true;
        if (this._timer) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
        }
        DisplayObjectUtil.removeFromParent(this._skipTimeBtn);
        DisplayObjectUtil.removeFromParent(this._leftTimeContainer);
    }

    private function startTimer():void {
        this._timer = new Timer(1000);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this._timer.start();
    }

    private function onTimer(param1:TimerEvent):void {
        if (this._timeLeftCount > 0) {
            --this._timeLeftCount;
        } else {
            this._canEnter = true;
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            DisplayObjectUtil.removeFromParent(this._skipTimeBtn);
            DisplayObjectUtil.removeFromParent(this._leftTimeContainer);
        }
        this.showLeftTime();
    }

    private function showLeftTime():void {
        this.shi = int(this._timeLeftCount / 3600);
        this.fen = int((this._timeLeftCount - 3600 * this.shi) / 60);
        this.miao = this._timeLeftCount - 3600 * this.shi - 60 * this.fen;
        this._leftTimeTxt.text = "" + (this.shi < 10 ? "0" + String(this.shi) : String(this.shi)) + ":" + (this.fen < 10 ? "0" + String(this.fen) : String(this.fen)) + ":" + (this.miao < 10 ? "0" + String(this.miao) : String(this.miao));
    }

    private function getMovie(param1:String):DisplayObject {
        if (this._resLibs) {
            return DomainUtil.getDisplayObject(param1, this._resLibs);
        }
        return null;
    }
}
}
