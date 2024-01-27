package com.taomee.seer2.app.rightToolbar {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.dream.DreamManager;
import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class RightToolbarConter implements IRightToolbarConter {

    private static var _instance:RightToolbarConter;


    private var _toolbarVec:Vector.<RightToolbar>;

    private var _upToolbarVec:Vector.<RightToolbar>;

    private var _leftToolbarVec:Vector.<RightToolbar>;

    private var _rightRollToolbarVec:Vector.<RightToolbar>;

    private var _leftRollToolbarVec:Vector.<RightToolbar>;

    private var _isFirstLogin:Boolean;

    private var hideState:Boolean;

    private var _mcPanel:Sprite;

    private var _mcBg:MovieClip;

    private var _rightRoll:MovieClip;

    private var _leftRoll:MovieClip;

    private var _rightBtn:SimpleButton;

    private var _leftBtn:SimpleButton;

    private var _isRightShow:Boolean = true;

    private var _isLeftShow:Boolean = true;

    private const MIN_WIDTH:int = 860;

    private const MAX_WIDTH:int = 960;

    private const SINGLE_LINE_MAX:int = 11;

    private const INTERVAL:int = 5;

    private var _currentWidth:uint;

    public function RightToolbarConter() {
        this._toolbarVec = new Vector.<RightToolbar>();
        this._upToolbarVec = new Vector.<RightToolbar>();
        this._leftToolbarVec = new Vector.<RightToolbar>();
        this._rightRollToolbarVec = new Vector.<RightToolbar>();
        this._leftRollToolbarVec = new Vector.<RightToolbar>();
        this._mcPanel = new Sprite();
        super();
        this._mcPanel.x = LayerManager.stage.stageWidth;
        this._mcPanel.y = -30;
        LayerManager.uiLayer.addChild(this._mcPanel);
        this._mcBg = UIManager.getMovieClip("rightToolbarBg");
        this._rightRoll = UIManager.getMovieClip("rightRoll");
        this._rightRoll["btn"].addEventListener(MouseEvent.CLICK, this.onRollRightHide);
        this._leftRoll = UIManager.getMovieClip("leftRoll");
        this._leftRoll["btn"].addEventListener(MouseEvent.CLICK, this.onRollLeftHide);
        this._rightBtn = UIManager.getButton("rightBtn");
        LayerManager.uiLayer.addChild(this._rightBtn);
        this._rightBtn.addEventListener(MouseEvent.CLICK, this.onRollRightShow);
        this._leftBtn = UIManager.getButton("leftBtn");
        LayerManager.uiLayer.addChild(this._leftBtn);
        this._leftBtn.addEventListener(MouseEvent.CLICK, this.onRollLeftShow);
    }

    public static function get instance():RightToolbarConter {
        if (!_instance) {
            _instance = new RightToolbarConter();
        }
        return _instance;
    }

    private static function sortVec(param1:RightToolbar, param2:RightToolbar):int {
        if (param1.info.sort > param2.info.sort) {
            return 1;
        }
        if (param1.info.sort < param2.info.sort) {
            return -1;
        }
        return 0;
    }

    public function get toolbarVec():Vector.<RightToolbar> {
        return this._toolbarVec;
    }

    public function get leftToolbarVec():Vector.<RightToolbar> {
        return this._leftToolbarVec;
    }

    public function initEvent():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapSwitchComplete);
        SceneManager.addEventListener(SceneEvent.SWITCH_START, this.onMapSwitchStart);
    }

    private function onMapSwitchComplete(param1:SceneEvent):void {
        if (this._isFirstLogin == false) {
            this._isFirstLogin = true;
            RightToolbarTimeCheck.getServerBuf();
            this.refreshTime();
        } else if (this.isCanShow()) {
            this.update();
            this.upupdate();
            this.leftUpdate();
            this.addRoll();
            this.newPlayerShowFilter();
        }
    }

    private function isCanShow():Boolean {
        if (this.hideState) {
            return false;
        }
        if (SceneManager.active == null) {
            return false;
        }
        if (SceneManager.active.type == SceneType.ARENA || SceneManager.active.type == SceneType.TEAM || SceneManager.active.type == SceneType.GUDIE_ARENA || SceneManager.active.type == SceneType.PLANT || SceneManager.active.type == SceneType.GUDIE_ARENA2 || SceneManager.active.type == SceneType.GUDIE_ARENA3 || SceneManager.active.type == SceneType.GUDIE_ARENA5 || SceneManager.active.type == SceneType.GUDIE_ARENA4 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA1 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA2 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA3) {
            return false;
        }
        if (Boolean(SceneManager.active) && DreamManager.isDreamMap()) {
            return false;
        }
        if (SceneManager.active.type == SceneType.HOME) {
            return false;
        }
        if (SceneManager.active.mapID == 81) {
            return false;
        }
        if (SceneManager.active.mapID == 1030 || SceneManager.active.mapID == 1031 || SceneManager.active.mapID == 1032) {
            return false;
        }
        return true;
    }

    private function onMapSwitchStart(param1:SceneEvent):void {
        this.removeAll();
    }

    public function addRollRightToolbar(param1:RightToolbar):void {
        var _loc2_:int = this._rightRollToolbarVec.indexOf(param1);
        if (_loc2_ == -1) {
            this._rightRollToolbarVec.push(param1);
            this.updateRollRightInit();
        }
    }

    public function addRollLeftToolbar(param1:RightToolbar):void {
        var _loc2_:int = this._leftRollToolbarVec.indexOf(param1);
        if (_loc2_ == -1) {
            this._leftRollToolbarVec.push(param1);
            this.updateRollLeftInit();
        }
    }

    private function updateRollRightInit():void {
        var defineUpToolbarVec:Vector.<RightToolbar> = null;
        if (this._rightRoll.parent == null) {
            LayerManager.uiLayer.addChildAt(this._rightRoll, 0);
        }
        defineUpToolbarVec = this.getDefinedToolbarVec(this._rightRollToolbarVec);
        ActiveCountManager.requestActiveCount(250675, function (param1:uint, param2:int):void {
            var _loc3_:int = 0;
            while (_loc3_ < defineUpToolbarVec.length) {
                defineUpToolbarVec[_loc3_].y = -2;
                defineUpToolbarVec[_loc3_].x = -(80 + 55 * _loc3_);
                defineUpToolbarVec[_loc3_].update();
                if (param2 > 0 && defineUpToolbarVec[_loc3_].info.sort == 42) {
                    defineUpToolbarVec[_loc3_].visible = false;
                }
                _rightRoll.addChild(defineUpToolbarVec[_loc3_]);
                _loc3_++;
            }
            updateRollRight();
        });
    }

    public function newPlayerShowFilter():void {
        if (NewPlayerGuideTimeManager.curTimeCheck() && !NewPlayerGuideTimeManager.timeCheckNewGuide()) {
            if (QuestManager.isStepComplete(83, 9)) {
                LayerManager.uiLayer.addChild(this._rightRoll);
                LayerManager.uiLayer.addChild(this._mcPanel);
                this._rightRoll.visible = this._mcPanel.visible = true;
            } else {
                DisplayObjectUtil.removeFromParent(this._rightRoll);
                DisplayObjectUtil.removeFromParent(this._mcPanel);
                this._rightRoll.visible = this._mcPanel.visible = false;
            }
        } else if (NewPlayerGuideTimeManager.timeCheckNewGuide()) {
            if (QuestManager.isStepComplete(99, 7)) {
                LayerManager.uiLayer.addChild(this._rightRoll);
                LayerManager.uiLayer.addChild(this._mcPanel);
                this._rightRoll.visible = this._mcPanel.visible = true;
            } else {
                DisplayObjectUtil.removeFromParent(this._rightRoll);
                DisplayObjectUtil.removeFromParent(this._mcPanel);
                this._rightRoll.visible = this._mcPanel.visible = false;
            }
        }
    }

    private function clearRollRight():void {
        while (this._rightRoll.numChildren > 0) {
            this._rightRoll.removeChildAt(0);
        }
    }

    public function updateRollLeftInit():void {
        if (this._leftRoll.parent == null) {
            LayerManager.uiLayer.addChild(this._leftRoll);
        }
        var _loc1_:int = 0;
        while (_loc1_ < this._leftRollToolbarVec.length) {
            this._leftRollToolbarVec[_loc1_].y = -3;
            this._leftRollToolbarVec[_loc1_].x = 30 + 55 * _loc1_;
            this._leftRollToolbarVec[_loc1_].update();
            this._leftRoll.addChild(this._leftRollToolbarVec[_loc1_]);
            _loc1_++;
        }
        this.updateRollLeft();
    }

    public function addToolbar(param1:RightToolbar):void {
        var _loc2_:int = this._toolbarVec.indexOf(param1);
        if (_loc2_ == -1) {
            this._toolbarVec.push(param1);
            this._toolbarVec.sort(sortVec);
            this.update();
        }
    }

    public function removeToolbar(param1:RightToolbar):void {
        var _loc2_:int = this._toolbarVec.indexOf(param1);
        if (_loc2_ != -1) {
            this._toolbarVec.splice(_loc2_, 1);
            DisplayUtil.removeForParent(param1);
            this._toolbarVec.sort(sortVec);
            this.update();
        }
    }

    public function addLeftToolbar(param1:RightToolbar, param2:Boolean = true):void {
        var _loc3_:int = this._leftToolbarVec.indexOf(param1);
        if (_loc3_ == -1) {
            this._leftToolbarVec.push(param1);
            this._leftToolbarVec.sort(sortVec);
            this.leftUpdate();
        }
    }

    public function removeLeftToolbar(param1:RightToolbar):void {
        var _loc2_:int = this._leftToolbarVec.indexOf(param1);
        if (_loc2_ != -1) {
            this._leftToolbarVec.splice(_loc2_, 1);
            DisplayUtil.removeForParent(param1);
            this._leftToolbarVec.sort(sortVec);
            this.leftUpdate();
        }
    }

    public function getToolbarPoint(param1:String):Point {
        var _loc2_:RightToolbar = null;
        for each(_loc2_ in this._toolbarVec) {
            if (_loc2_.info.url == param1) {
                return new Point(_loc2_.x, _loc2_.y);
            }
        }
        return null;
    }

    public function getLeftToolbarPoint(param1:String):Point {
        var _loc2_:RightToolbar = null;
        for each(_loc2_ in this._leftToolbarVec) {
            if (_loc2_.info.url == param1) {
                return new Point(_loc2_.x, _loc2_.y);
            }
        }
        return null;
    }

    public function addUpToolbar(param1:RightToolbar):void {
        var _loc2_:int = this._upToolbarVec.indexOf(param1);
        if (_loc2_ == -1) {
            this._upToolbarVec.push(param1);
            this.upupdate();
        }
    }

    public function removeUpToolbar(param1:RightToolbar):void {
        var _loc2_:int = this._upToolbarVec.indexOf(param1);
        if (_loc2_ != -1) {
            this._upToolbarVec.splice(_loc2_, 1);
            DisplayUtil.removeForParent(param1);
            this.upupdate();
        }
    }

    public function hide():void {
        var _loc2_:RightToolbar = null;
        var _loc3_:RightToolbar = null;
        var _loc4_:RightToolbar = null;
        var _loc5_:RightToolbar = null;
        this.hideState = true;
        var _loc1_:uint = 0;
        while (_loc1_ < this._toolbarVec.length) {
            this._toolbarVec[_loc1_].visible = false;
            _loc1_++;
        }
        for each(_loc2_ in this._upToolbarVec) {
            _loc2_.visible = false;
        }
        for each(_loc3_ in this._leftToolbarVec) {
            _loc3_.visible = false;
        }
        for each(_loc4_ in this._rightRollToolbarVec) {
            _loc4_.visible = false;
        }
        for each(_loc5_ in this._leftRollToolbarVec) {
            _loc5_.visible = false;
        }
        if (this._mcBg) {
            this._mcBg.visible = false;
        }
        if (this._rightRoll) {
            this._rightRoll.visible = false;
        }
        if (this._rightBtn) {
            this._rightBtn.visible = false;
        }
        if (this._leftRoll) {
            this._leftRoll.visible = false;
        }
        if (this._leftBtn) {
            this._leftBtn.visible = false;
        }
    }

    public function hideRightAndLeft():void {
        this.onRollLeftHide(null);
    }

    public function show():void {
        var _loc2_:RightToolbar = null;
        var _loc3_:RightToolbar = null;
        var _loc4_:RightToolbar = null;
        var _loc5_:RightToolbar = null;
        this.hideState = false;
        var _loc1_:uint = 0;
        while (_loc1_ < this._toolbarVec.length) {
            this._toolbarVec[_loc1_].visible = true;
            _loc1_++;
        }
        for each(_loc2_ in this._upToolbarVec) {
            _loc2_.visible = true;
        }
        for each(_loc3_ in this._leftToolbarVec) {
            _loc3_.visible = true;
        }
        for each(_loc4_ in this._rightRollToolbarVec) {
            _loc4_.visible = true;
        }
        for each(_loc5_ in this._leftRollToolbarVec) {
            _loc5_.visible = true;
        }
        if (Boolean(SceneManager.active) && SceneManager.active.type == SceneType.ARENA) {
            return;
        }
        if (this._mcBg) {
            this._mcBg.visible = true;
        }
        if (this._rightRoll) {
            this._rightRoll.visible = true;
        }
        if (this._leftRoll) {
            this._leftRoll.visible = true;
        }
        if (Boolean(this._rightBtn) && this._isRightShow) {
            this._rightBtn.visible = this._isRightShow;
        }
        if (Boolean(this._leftBtn) && this._isLeftShow) {
            this._leftBtn.visible = this._isRightShow;
        }
        this.newPlayerShowFilter();
    }

    public function update():void {
        var _loc1_:RightToolbar = null;
        if (this.isCanShow()) {
            for each(_loc1_ in this._toolbarVec) {
                _loc1_.update();
                LayerManager.uiLayer.addChild(_loc1_);
            }
            this.layIconsRight();
        }
    }

    public function leftUpdate():void {
        var _loc1_:RightToolbar = null;
        if (this.isCanShow()) {
            for each(_loc1_ in this._leftToolbarVec) {
                _loc1_.update();
                LayerManager.uiLayer.addChild(_loc1_);
            }
            this.layIconsLeft();
        }
    }

    private function layIconsLeft():void {
        var _loc1_:RightToolbar = null;
        var _loc2_:int = 0;
        while (_loc2_ < this._leftToolbarVec.length) {
            _loc1_ = this._leftToolbarVec[_loc2_];
            _loc1_.x = 30 + 52 * _loc2_;
            _loc1_.y = 120;
            _loc2_++;
        }
    }

    private function layIconsRight():void {
        var _loc1_:RightToolbar = null;
        var _loc2_:int = 0;
        while (_loc2_ < this._toolbarVec.length) {
            _loc1_ = this._toolbarVec[_loc2_];
            _loc1_.x = LayerManager.stage.stageWidth - 65;
            _loc1_.y = 370 + 52 * _loc2_;
            _loc2_++;
        }
    }

    private function layIcons():void {
        var _loc8_:RightToolbar = null;
        this._currentWidth = Math.min(this.MIN_WIDTH + LayerManager.stage.stageWidth - 1150, this.MAX_WIDTH);
        this._mcPanel.x = LayerManager.stage.stageWidth;
        this.updateRollRight();
        this.updateRollLeft();
        this.clearDefinedUpToolbar();
        var _loc1_:Number = 0;
        var _loc2_:Number = 0;
        var _loc3_:Array = [];
        var _loc4_:Array = [];
        var _loc5_:int = 1;
        var _loc6_:int = 0;
        var _loc7_:int = int(this._upToolbarVec.length);
        var _loc9_:Vector.<RightToolbar> = this.getDefinedToolbarVec(this._upToolbarVec);
        var _loc10_:int = 0;
        while (_loc10_ < _loc9_.length) {
            _loc8_ = _loc9_[_loc10_];
            if (_loc10_ == 0) {
                _loc3_[_loc10_] = 0 - 64;
                _loc1_ = Math.abs(_loc3_[_loc10_]);
                _loc4_[_loc10_] = 0;
                _loc6_++;
            } else if (_loc1_ + this.INTERVAL + _loc8_.width <= this._currentWidth && _loc6_ < this.SINGLE_LINE_MAX) {
                _loc3_[_loc10_] = 0 - (_loc1_ + this.INTERVAL + 64);
                _loc1_ = Math.abs(_loc3_[_loc10_]);
                _loc4_[_loc10_] = 64 * (_loc5_ - 1);
                _loc5_ = _loc5_;
                _loc6_++;
            } else {
                _loc5_++;
                _loc3_[_loc10_] = 0 - 64;
                _loc1_ = Math.abs(_loc3_[_loc10_]);
                _loc4_[_loc10_] = 64 * (_loc5_ - 1);
                _loc6_ = 1;
            }
            _loc10_++;
        }
        _loc10_ = 0;
        while (_loc10_ < _loc9_.length) {
            (_loc8_ = _loc9_[_loc10_]).update();
            DisplayUtil.removeForParent(_loc8_);
            _loc8_.x = _loc3_[_loc10_];
            _loc8_.y = _loc4_[_loc10_] + 38;
            this._mcPanel.addChild(_loc8_);
            _loc10_++;
        }
        DisplayUtil.removeForParent(this._mcBg);
        this._mcPanel.addChildAt(this._mcBg, 0);
        this._mcBg.y = 31;
    }

    private function clearDefinedUpToolbar():void {
        while (this._mcPanel.numChildren > 0) {
            this._mcPanel.removeChildAt(0);
        }
    }

    private function getDefinedToolbarVec(param1:Vector.<RightToolbar>):Vector.<RightToolbar> {
        var _loc3_:RightToolbar = null;
        var _loc2_:Vector.<RightToolbar> = new Vector.<RightToolbar>();
        for each(_loc3_ in param1) {
            if (_loc3_.info.isDefinedOpen) {
                _loc2_.push(_loc3_);
            }
        }
        return _loc2_;
    }

    private function onRollRightShow(param1:MouseEvent):void {
        this._rightBtn.visible = false;
        this._isRightShow = true;
        TweenLite.to(this._rightRoll, 0.6, {
            "x": LayerManager.stage.stageWidth,
            "ease": Expo.easeOut,
            "onComplete": this.onTweenRightComplete
        });
    }

    private function onRollRightHide(param1:MouseEvent):void {
        this._isRightShow = false;
        TweenLite.to(this._rightRoll, 0.6, {
            "x": LayerManager.stage.stageWidth + 620,
            "onComplete": this.onTweenRightComplete
        });
    }

    private function onTweenRightComplete():void {
        this.updateRollRight();
    }

    private function onRollLeftShow(param1:MouseEvent):void {
        this._leftBtn.visible = false;
        this._isLeftShow = true;
        TweenLite.to(this._leftRoll, 0.6, {
            "x": 0,
            "ease": Expo.easeOut,
            "onComplete": this.onTweenLeftComplete
        });
    }

    private function onRollLeftHide(param1:MouseEvent):void {
        this._isLeftShow = false;
        TweenLite.to(this._leftRoll, 0.6, {
            "x": -245,
            "onComplete": this.onTweenLeftComplete
        });
    }

    private function onTweenLeftComplete():void {
        this.updateRollLeft();
    }

    private function updateRollRight():void {
        this._rightRoll.y = 73;
        this._rightBtn.y = 73;
        if (this._isRightShow) {
            this._rightRoll.x = LayerManager.stage.stageWidth;
            this._rightBtn.visible = false;
        } else {
            this._rightRoll.x = LayerManager.stage.stageWidth + 620;
            this._rightBtn.x = LayerManager.stage.stageWidth;
            this._rightBtn.visible = true;
        }
    }

    private function updateRollLeft():void {
        this._leftRoll.y = 153;
        this._leftBtn.y = 153;
        if (this._isLeftShow) {
            this._leftRoll.x = 0;
            this._leftBtn.visible = false;
        } else {
            this._leftRoll.x = -245;
            this._leftBtn.x = 0;
            this._leftBtn.visible = true;
        }
    }

    public function upupdate():void {
        if (this.isCanShow()) {
            this.layIcons();
            this.layIconsRight();
            this.layIconsLeft();
        }
    }

    public function refreshTime():void {
        var _loc1_:RightToolbar = null;
        for each(_loc1_ in this._toolbarVec) {
            if (this.isCanShow()) {
                _loc1_.refreshTime();
            }
        }
    }

    public function addRoll():void {
        var _loc1_:RightToolbar = null;
        var _loc2_:RightToolbar = null;
        if (this._rightRoll) {
            this._rightRoll.visible = true;
        }
        if (this._leftRoll) {
            this._leftRoll.visible = true;
        }
        for each(_loc1_ in this._rightRollToolbarVec) {
            _loc1_.update();
            _loc1_.visible = true;
        }
        for each(_loc2_ in this._leftRollToolbarVec) {
            _loc2_.update();
            _loc2_.visible = true;
        }
    }

    public function removeAll():void {
        var _loc1_:RightToolbar = null;
        var _loc2_:RightToolbar = null;
        var _loc3_:RightToolbar = null;
        var _loc4_:RightToolbar = null;
        var _loc5_:RightToolbar = null;
        for each(_loc1_ in this._toolbarVec) {
            _loc1_.remove();
        }
        for each(_loc2_ in this._upToolbarVec) {
            _loc2_.remove();
        }
        for each(_loc3_ in this._leftToolbarVec) {
            _loc3_.remove();
        }
        for each(_loc4_ in this._rightRollToolbarVec) {
            _loc4_.remove();
        }
        for each(_loc5_ in this._leftRollToolbarVec) {
            _loc5_.remove();
        }
        if (this._rightRoll) {
            this._rightRoll.visible = false;
        }
        if (this._leftRoll) {
            this._leftRoll.visible = false;
        }
    }

    public function toolbarLight(param1:String):void {
        var _loc2_:RightToolbar = null;
        var _loc3_:RightToolbar = null;
        for each(_loc3_ in this._toolbarVec) {
            if (_loc3_.info.url == param1) {
                _loc2_ = _loc3_;
            }
        }
        if (_loc2_ != null) {
            _loc2_.onLight();
        }
    }
}
}
