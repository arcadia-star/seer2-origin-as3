package com.taomee.seer2.app.rightToolbar {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dream.DreamManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.rightToolbar.config.RightToolbarInfo;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.utils.IDataInput;
import flash.utils.getDefinitionByName;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class RightToolbar extends Sprite implements IToolBar {


    public var type:String;

    protected var _isShowTime:Boolean;

    protected var _isShowTimeComplete:Boolean;

    protected var _btn:SimpleButton;

    protected var _conisMC:MovieClip;

    protected var _rightClick:uint;

    protected var _timeCount:uint;

    protected var _timeMC:MovieClip;

    protected var _timeComplete:MovieClip;

    protected var _info:RightToolbarInfo;

    private var _rightToolBarTime:RightToolBarTime;

    private var _rightToolBarTimeComplete:RightToolBarTimeComplete;

    private var _isShowLift:Boolean;

    private var _downListBg:MovieClip;

    private var _downItemList:Vector.<RightToolbar>;

    private var _showPointMC:MovieClip;

    public function RightToolbar() {
        this.type = RightToolbarType.TIME;
        this._rightToolBarTime = new RightToolBarTime();
        this._rightToolBarTimeComplete = new RightToolBarTimeComplete();
        super();
    }

    public function init(param1:RightToolbarInfo):void {
        this._info = param1;
        this._rightClick = 1;
    }

    public function get info():RightToolbarInfo {
        return this._info;
    }

    protected function setShowTime(param1:Boolean, param2:uint):void {
        this._isShowTime = param1;
        this._timeCount = param2;
    }

    protected function setShowTimeComplete(param1:Boolean):void {
        this._isShowTimeComplete = param1;
    }

    public function get isShowTime():Boolean {
        return this._isShowTime;
    }

    public function update():void {
        if (this.isFightHomeIng() == false) {
            return;
        }
        if (this._btn) {
            this.show();
        } else {
            QueueLoader.load(URLUtil.getRes("loaderLibrary/rightToolbar/" + this._info.sort + ".swf"), LoadType.SWF, this.onResLoaded);
        }
    }

    protected function onResLoaded(param1:ContentInfo):void {
        this._btn = (param1.content as MovieClip)["btn"];
        TooltipManager.addCommonTip(this._btn, this._info.tip);
        this.show();
    }

    protected function show():void {
        this.remove();
        addChild(this._btn);
        if (this._isShowTime) {
            this.showTime();
        } else {
            this.removeTime();
        }
        if (this._isShowTimeComplete) {
            this.timeComplete();
        } else {
            this.removeTimeComplete();
        }
        if (this.info.isShowPoint == 1 && this.info.showPointIndex == 0) {
            DisplayUtil.removeForParent(this._showPointMC);
            if (this._showPointMC == null) {
                this._showPointMC = UIManager.getMovieClip("showPointMC");
            }
            this._showPointMC.x = 32;
            this._showPointMC.y = -6;
            addChild(this._showPointMC);
        }
        if (this._rightClick == 0) {
            DisplayUtil.removeForParent(this._conisMC);
            if (this._conisMC == null) {
                this._conisMC = UIManager.getMovieClip("rightToolbarConis");
            }
            this._conisMC.x = -3;
            this._conisMC.y = 36;
            addChild(this._conisMC);
            this._conisMC.visible = false;
        }
        if (Boolean(this.info.toolbarInfoList) && this.info.toolbarInfoList.length > 0) {
            this.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
        }
        this._btn.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onOver(param1:MouseEvent):void {
        var _loc2_:RightToolbar = null;
        var _loc3_:* = undefined;
        this.clearDownList();
        if (this._downListBg == null) {
            this._downListBg = UIManager.getMovieClip("downListBg");
        }
        if (this._downListBg.parent == null) {
            this._downListBg.x = -5;
            this.addChildAt(this._downListBg, 0);
        }
        this._downItemList = new Vector.<RightToolbar>();
        this._downListBg.height = 30 + this.info.toolbarInfoList.length * 70;
        var _loc4_:int = 0;
        while (_loc4_ < this.info.toolbarInfoList.length) {
            _loc2_ = new RightToolbar();
            if (this.info.toolbarInfoList[_loc4_].classStr != "") {
                _loc3_ = getDefinitionByName("com.taomee.seer2.app.rightToolbar.toolbar." + this.info.toolbarInfoList[_loc4_].classStr);
                _loc2_ = new _loc3_() as RightToolbar;
            } else {
                _loc2_ = new RightToolbar();
            }
            _loc2_.init(this.info.toolbarInfoList[_loc4_]);
            _loc2_.update();
            _loc2_.x = 2;
            _loc2_.y = 60 + _loc4_ * 55;
            addChild(_loc2_);
            this._downItemList.push(_loc2_);
            _loc4_++;
        }
    }

    private function onOut(param1:MouseEvent):void {
        this.clearDownList();
        DisplayUtil.removeForParent(this._downListBg);
    }

    private function clearDownList():void {
        var _loc1_:RightToolbar = null;
        if (this._downListBg) {
            for each(_loc1_ in this._downItemList) {
                DisplayUtil.removeForParent(_loc1_);
            }
            this._downItemList = Vector.<RightToolbar>([]);
            DisplayObjectUtil.removeFromParent(this._downListBg);
            this._downListBg = null;
        }
    }

    public function onLight():void {
        this.setShowTimeComplete(true);
        this._isShowLift = true;
        this.update();
    }

    protected function onClick(param1:MouseEvent):void {
        var sceneType:int = 0;
        var mapId:uint = 0;
        var event:MouseEvent = param1;
        this._isShowTimeComplete = false;
        this.removeTimeComplete();
        if (this._info.sort) {
            StatisticsManager.newSendNovice("2014UI触达率", "主ICON点击数", "主ICON" + this._info.sort + "号点击");
        }
        if (this._info.clickType == "null") {
            return;
        }
        if (this._info.clickType == "gotoMap") {
            sceneType = int(SceneType.LOBBY);
            mapId = uint(int(this._info.clickParams));
            if (this._info.clickParams == "50000") {
                sceneType = int(SceneType.HOME);
                mapId = ActorManager.actorInfo.id;
            } else if (this._info.clickParams == "70000") {
                sceneType = int(SceneType.PLANT);
                mapId = ActorManager.actorInfo.id;
            }
            SceneManager.changeScene(sceneType, mapId);
        }
        if (this._info.clickType == "module") {
            ModuleManager.showModule(URLUtil.getAppModule(this._info.clickParams), "正在加载资源...");
        }
        if (this._info.url == "sniperToolbar") {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_111);
        } else if (this._info.url == "anniversary") {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_112);
        } else if (this._info.url == "planet") {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_113);
        }
        if (this._rightClick == 0) {
        }
        if (this.info.isShowPoint == 1 && this.info.showPointIndex == 0) {
            SwapManager.swapItem(3532, 1, function (param1:IDataInput):void {
                info.showPointIndex = 1;
                DisplayUtil.removeForParent(_showPointMC);
            }, null, new SpecialInfo(1, this.info.sort));
        }
        SoundEffects.playSoundMouseClick();
    }

    public function showTime():void {
        if (!this._timeMC) {
            this._timeMC = UIManager.getMovieClip("UI_Right_Time");
            this.updateTime();
        } else {
            this.updateTime();
        }
    }

    private function updateTime():void {
        this._timeMC.x = -3;
        this._timeMC.y = 50;
        addChild(this._timeMC);
        Tick.instance.addRender(this.updateTimeMC, 1000);
        this.updateTimeMC(1111);
    }

    private function updateTimeComplete():void {
        this._timeComplete.x = 27;
        this._timeComplete.y = 25;
        addChild(this._timeComplete);
        this._timeComplete.play();
        this._timeComplete.mouseChildren = false;
        this._timeComplete.mouseEnabled = false;
    }

    protected function updateTimeMC(param1:uint):void {
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        if (this._timeCount > 0) {
            _loc2_ = uint(this._timeCount / 60);
            _loc3_ = this._timeCount % 60;
            (this._timeMC["mcMinDecade"] as MovieClip).gotoAndStop(uint(_loc2_ / 10) + 1);
            (this._timeMC["mcMinUnit"] as MovieClip).gotoAndStop(uint(_loc2_ % 10) + 1);
            (this._timeMC["mcSecDecade"] as MovieClip).gotoAndStop(uint(_loc3_ / 10) + 1);
            (this._timeMC["mcSecUnit"] as MovieClip).gotoAndStop(uint(_loc3_ % 10) + 1);
            --this._timeCount;
        }
        if (this._timeCount <= 0) {
            this.removeTime();
            this.timeComplete();
        }
    }

    protected function get timeCount():uint {
        return this._timeCount;
    }

    protected function timeComplete():void {
        this._isShowTime = false;
        if (!this._timeComplete) {
            this._timeComplete = UIManager.getMovieClip("UI_Time_Complete");
            this.updateTimeComplete();
        } else {
            this.updateTimeComplete();
        }
    }

    protected function get btn():SimpleButton {
        return this._btn;
    }

    private function removeTime():void {
        if (Boolean(this._timeMC) && Boolean(this._timeMC.parent)) {
            this._timeMC.parent.removeChild(this._timeMC);
        }
        Tick.instance.removeRender(this.updateTimeMC);
    }

    protected function removeTimeComplete():void {
        if (Boolean(this._timeComplete) && Boolean(this._timeComplete.parent)) {
            this._isShowLift = false;
            this._timeComplete.parent.removeChild(this._timeComplete);
        }
    }

    public function remove():void {
        this.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
        this.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
        this.removeTime();
        this.removeTimeComplete();
        if (Boolean(this._btn) && Boolean(this._btn.parent)) {
            this._btn.parent.removeChild(this._btn);
            this._btn.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        DisplayUtil.removeForParent(this._conisMC);
        this.clearDownList();
    }

    public function refreshTime():void {
        var _loc1_:Array = null;
        var _loc2_:uint = 0;
        if (this._info.lightStartTime == "") {
            return;
        }
        if (RightToolbarTimeCheck.isTimeContent(this._info.startTime, this._info.lightStartTime) && this._isShowTime == false) {
            _loc1_ = this._info.lightStartTime.split("_");
            _loc2_ = new Date(_loc1_[0], _loc1_[1] - 1, _loc1_[2], _loc1_[3], _loc1_[4]).getTime() / 1000;
            if (TimeManager.getServerTime() > _loc2_) {
                this._isShowTime = false;
                this._timeCount = 0;
            } else {
                this._isShowTime = true;
                this._timeCount = _loc2_ - TimeManager.getServerTime();
                this.update();
            }
        }
        if (RightToolbarTimeCheck.isTimeContent(this._info.lightStartTime, this._info.endTime) && this._isShowLift == false) {
            this.setShowTimeComplete(true);
            this._isShowLift = true;
            this.update();
        } else if (RightToolbarTimeCheck.isTimeContent(this._info.lightStartTime, this._info.endTime) == false && this._isShowLift == true) {
            this.setShowTimeComplete(false);
            this._isShowLift = false;
            this.update();
        }
    }

    private function isFightHomeIng():Boolean {
        if (SceneManager.active == null) {
            return false;
        }
        if (SceneManager.active.type == SceneType.ARENA || SceneManager.active.type == SceneType.TEAM || SceneManager.active.type == SceneType.GUDIE_ARENA || SceneManager.active.type == SceneType.GUDIE_ARENA2 || SceneManager.active.type == SceneType.GUDIE_ARENA3 || SceneManager.active.type == SceneType.GUDIE_ARENA4 || SceneManager.active.type == SceneType.GUDIE_ARENA5 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA1 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA2 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA3) {
            return false;
        }
        if (Boolean(SceneManager.active) && DreamManager.isDreamMap()) {
            return false;
        }
        if (SceneManager.active.type == SceneType.HOME) {
            return false;
        }
        return true;
    }

    public function goTime():void {
    }
}
}
