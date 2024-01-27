package com.taomee.seer2.app.guide.manager {
import com.taomee.seer2.app.guide.info.GuideInfo;
import com.taomee.seer2.app.guide.info.TipInfo;
import com.taomee.seer2.app.guide.utils.AdjectiveMask;
import com.taomee.seer2.app.guide.utils.GuideTip;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;

public class GuideManager {

    private static var _instance:GuideManager = null;

    private static const VIEW_WIDTH:Number = 1200;

    private static const VIEW_HEIGHT:Number = 660;


    private var _guideList:Array;

    private var _parentList:Array;

    private var _targetList:Array;

    private var _parent:*;

    private var _target:*;

    private var _guideTip:GuideTip;

    private var _mask:Sprite;

    public var _index:int = 0;

    private var _skipBtn:SimpleButton;

    private var _skipFun:Function;

    private var _btn:TextField;

    private var gInfo:GuideInfo;

    public function GuideManager(param1:SingletonClass) {
        this._guideList = new Array();
        this._parentList = [];
        this._targetList = [];
        this._guideTip = new GuideTip();
        this._mask = new Sprite();
        this._btn = new TextField();
        super();
        LayerManager.stage.addEventListener(Event.RESIZE, this.updateView);
    }

    public static function get instance():GuideManager {
        if (_instance == null) {
            _instance = new GuideManager(new SingletonClass());
        }
        return _instance;
    }

    public function initGuideTip(param1:DisplayObject = null):void {
    }

    public function startGuide(param1:int = 0, param2:Function = null):void {
        var _loc3_:TipInfo = null;
        this._index = param1;
        this._skipFun = param2;
        if (this._index < this._guideList.length) {
            this.gInfo = this._guideList[this._index];
            if (this.gInfo) {
                if (this._parentList[this.gInfo.parentIndex]) {
                    this._parent = this._parentList[this.gInfo.parentIndex];
                }
                if (this.gInfo.targetIndex != -1) {
                    this._target = this._targetList[this.gInfo.targetIndex];
                    if (this.gInfo.isNext) {
                        this._target.addEventListener(MouseEvent.CLICK, this.nextGuide);
                    }
                }
                this.updateView();
            }
            if (this._skipFun != null) {
                this.addFullScreenSkipBtn();
            }
        } else {
            this.endGuide();
        }
    }

    public function updateView(param1:Event = null):void {
        var _loc4_:Rectangle = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc2_:Number = 0;
        var _loc3_:Number = 0;
        if (this.gInfo == null) {
            return;
        }
        _loc2_ = VIEW_WIDTH - LayerManager.stage.stageWidth;
        if (this.gInfo.isLockY == false) {
            _loc3_ = VIEW_HEIGHT - LayerManager.stage.stageHeight;
        }
        if (this.gInfo.isLockX == false) {
            if (this.gInfo.isModule == false) {
                _loc4_ = new Rectangle(this.gInfo.pointX - _loc2_, this.gInfo.pointY - _loc3_, this.gInfo.targetWidth, this.gInfo.targetHeight);
            } else {
                if (this.gInfo.moduleWidth >= VIEW_WIDTH) {
                    _loc5_ = LayerManager.stage.stageWidth <= 960 ? 960 : int(LayerManager.stage.stageWidth);
                    _loc6_ = LayerManager.stage.stageHeight <= 560 ? 560 : int(LayerManager.stage.stageHeight);
                } else {
                    _loc5_ = LayerManager.stage.stageWidth < this.gInfo.moduleWidth ? int(this.gInfo.moduleWidth) : int(LayerManager.stage.stageWidth);
                    _loc6_ = LayerManager.stage.stageHeight < this.gInfo.moduleHight ? int(this.gInfo.moduleHight) : int(LayerManager.stage.stageHeight);
                }
                _loc2_ = VIEW_WIDTH - _loc5_;
                _loc3_ = VIEW_HEIGHT - _loc6_;
                _loc4_ = new Rectangle(this.gInfo.pointX - _loc2_ / 2, this.gInfo.pointY - _loc3_ / 2, this.gInfo.targetWidth, this.gInfo.targetHeight);
            }
        } else {
            _loc2_ = this.gInfo.pointX;
            _loc4_ = new Rectangle(this.gInfo.pointX, this.gInfo.pointY - _loc3_, this.gInfo.targetWidth, this.gInfo.targetHeight);
        }
        if (!this._parent) {
            return;
        }
        this._mask = AdjectiveMask.instance.makeMask(Vector.<Rectangle>([_loc4_]), 0, 0, this._parent.width, this._parent.height);
        this._parent.addChild(this._mask);
        if (this.gInfo.dir > 0) {
            this._parent.addChild(this._guideTip);
            this._guideTip.showTip(Vector.<Rectangle>([_loc4_]), this.gInfo.dir);
        }
    }

    public function nextGuide(param1:MouseEvent = null):void {
        if (param1) {
            param1.currentTarget.removeEventListener(MouseEvent.CLICK, this.nextGuide);
        }
        if (Boolean(this.gInfo) && this.gInfo.isAuto) {
            ++this._index;
            this.startGuide(this._index);
        } else {
            this.removeLastMske();
        }
    }

    private function endGuide():void {
        this.removeLastMske();
        this._guideList.length = 0;
        this._targetList.length = 0;
        this._parent = null;
        this._target = null;
    }

    private function onClose(param1:MouseEvent):void {
        this.endGuide();
    }

    public function removeLastMske():void {
        if (this._parent) {
            if (Boolean(this._mask) && (this._parent as DisplayObjectContainer).contains(this._mask)) {
                this._parent.removeChild(this._mask);
                this._mask = null;
            }
            if (this._guideTip.parent) {
                this._parent.removeChild(this._guideTip);
            }
        }
        if (this._skipBtn) {
            DisplayObjectUtil.removeFromParent(this._skipBtn);
            this._skipBtn = null;
        }
    }

    public function set guideList(param1:Array):void {
        this._guideList = param1;
    }

    public function get guideList():Array {
        return this._guideList;
    }

    public function addGuide2Target(param1:*, param2:int, param3:int, param4:Point, param5:Boolean = false, param6:Boolean = true, param7:int = 8, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Number = 0, param12:Number = 0):void {
        var _loc13_:GuideInfo = null;
        (_loc13_ = new GuideInfo()).parentIndex = param2;
        _loc13_.targetIndex = param3;
        _loc13_.isNext = param5;
        _loc13_.isAuto = param6;
        _loc13_.pointX = param4.x;
        _loc13_.pointY = param4.y;
        _loc13_.targetWidth = param1.width;
        _loc13_.targetHeight = param1.height;
        _loc13_.isLockY = param8;
        _loc13_.isModule = param9;
        _loc13_.isLockX = param10;
        _loc13_.dir = param7;
        _loc13_.moduleWidth = param11;
        _loc13_.moduleHight = param12;
        if (this._guideList) {
            this._guideList[param3] = _loc13_;
        }
    }

    private function addFullScreenSkipBtn():void {
        if (this._skipBtn == null) {
            this._skipBtn = UIManager.getButton("UI_SkipBtn");
            this._skipBtn.x = LayerManager.rootRect.width - 100;
            this._skipBtn.y = LayerManager.rootRect.height - 50;
            this._skipBtn.addEventListener(MouseEvent.CLICK, this.onFullScreenSkillBtnClick);
        }
        this._parent.addChild(this._skipBtn);
    }

    private function removeFullScreenSkipBtn():void {
        DisplayObjectUtil.removeFromParent(this._skipBtn);
    }

    private function onFullScreenSkillBtnClick(param1:MouseEvent):void {
        this.pause();
        if (this._skipFun != null) {
            this._skipFun();
            this._skipFun = null;
        }
    }

    public function addParent(param1:*, param2:int):void {
        if (this._parentList) {
            this._parentList[param2] = param1;
        }
    }

    public function addTarget(param1:*, param2:int):void {
        if (this._targetList) {
            this._targetList[param2] = param1;
        }
    }

    public function getTarget(param1:int):* {
        return this._targetList[param1];
    }

    public function close():void {
        this.endGuide();
    }

    public function pause():void {
        this.removeLastMske();
    }
}
}

class SingletonClass {


    public function SingletonClass() {
        super();
    }
}
