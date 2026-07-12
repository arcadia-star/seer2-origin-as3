package com.taomee.seer2.core.module {
import com.greensock.TweenLite;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;

public class Module extends Sprite {


    private const WINDOW_W:int = 1200;

    private const WINDOW_H:int = 660;

    protected var _mainUI:MovieClip;

    protected var _closeBtn:SimpleButton;

    protected var _dragSprite:Sprite;

    protected var _lifecycleType:String = "nonce";

    protected var _cover:Boolean = true;

    protected var _offset:Point;

    private var _coverUI:Sprite;

    private var backGround:Bitmap;

    private var backData:BitmapData;

    private var _hideMap:Boolean = true;

    private var hasSetHide:Boolean = false;

    private var _shadow:Shape;

    private var _srcWidth:int;

    protected var _isAlign:Boolean = false;

    protected var _isAlignContent:Boolean = false;

    private var _rootRect:Rectangle;

    private var _setTimeout:uint;

    public function Module() {
        super();
    }

    public function set hideMap(param1:Boolean):void {
        this._hideMap = param1;
    }

    public function get lifecycleType():String {
        return this._lifecycleType;
    }

    public function setIsAlign():void {
        this._isAlign = true;
    }

    public function setIsAlignContent():void {
        this._isAlignContent = true;
    }

    public function setup():void {
    }

    public function init(param1:Object):void {
    }

    public function show():void {
        this.setBackGround();
        LayerManager.moduleLayer.addChild(this);
        this.setCoverUI();
        if (!this._isAlignContent) {
            DisplayUtil.align(this, 4, this._rootRect, this._offset);
            this._isAlignContent = true;
            //嘤：保证只调用一次！首次调用这个的时候面板内容可能还没有完全加载出来，这里可以保证根据背景版调整位置
            //原理是这样的：首次调用这两个东西的时候面板往往只加载出最基础的部分，代码中addChild和其他添加元件的代码还没有执行
            //一般来讲最基础部分应该是不歪的，后续添加的东西可能歪。
            //歪的原理是这样的：一个元件可能有透明部分或不显示部分很大，正常观察的时候感觉不到，但是隐藏的部分也计入面积
            //这部分透明的部分一旦超出背景板，就会使整个面板范围扩大。
            //由于美术设定都是以背景板为最大边界，溢出背景板的部分参与校准判断就会导致背景板看起来歪了（实际上也是歪了）
            //所以只调用一次，在背景板加载出来之后以背景板为对象校准一次，后续导致偏移的部分添加了也不要再校准
        }
        if (!this._isAlign) {
            this._setTimeout = setTimeout(this.align, 100);
            TweenLite.from(this, 0.3, {"alpha": 0});
        } else {
            this.align();
        }
    }

    protected function setCoverUI():void {
        if (this._cover) {
            if (this._coverUI == null) {
                this._coverUI = new UI_ScreenCover();
                this._coverUI.cacheAsBitmap = true;
            }
            if (LayerManager.moduleLayer.contains(this._coverUI) == false) {
                LayerManager.moduleLayer.addChildAt(this._coverUI, 0);
            }
        }
    }

    public function align():void {
        if (this._isAlign) return;//防止反复校准位置（导致偏移）
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        this._rootRect = new Rectangle(0, 0, this.WINDOW_W, this.WINDOW_H);
        if (!this._isAlignContent) {
            DisplayUtil.align(this, 4, this._rootRect, this._offset);
        }
        if (this.width >= this.WINDOW_W) {
            _loc1_ = LayerManager.stage.stageWidth <= 960 ? 960 : LayerManager.stage.stageWidth;
            _loc2_ = LayerManager.stage.stageHeight <= 560 ? 560 : LayerManager.stage.stageHeight;
        } else {
            _loc1_ = LayerManager.stage.stageWidth < this.width ? int(this.width) : LayerManager.stage.stageWidth;
            _loc2_ = LayerManager.stage.stageHeight < this.height ? int(this.height) : LayerManager.stage.stageHeight;
        }
        this.x += (_loc1_ - this.WINDOW_W) / 2;
        this.y += (_loc2_ - this.WINDOW_H) / 2;
        this._isAlign = true;
    }

    protected function setBackGround():void {
        this.hasSetHide = false;
        if (this._hideMap && !ModuleManager.hasHideMap) {
            ModuleManager.hasHideMap = this.hasSetHide = true;
            this.backGround = new Bitmap();
            this.backData = new BitmapData(this.WINDOW_W, this.WINDOW_H, false, 4278190080);
            this.backData.draw(LayerManager.stage);
            this.backGround.bitmapData = this.backData;
            LayerManager.moduleLayer.addChild(this.backGround);
            this.createShadow();
            LayerManager.hideMap();
        }
    }

    private function createShadow():void {
        if (!this._shadow) {
            this._shadow = new Shape();
            this._shadow.graphics.beginFill(0, 0.8);
            this._shadow.graphics.drawRect(0, 0, this.WINDOW_W, this.WINDOW_H);
            this._shadow.graphics.endFill();
        }
        LayerManager.moduleLayer.addChild(this._shadow);
    }

    private function checkShowMap():void {
        if (ModuleManager.hasHideMap && this.hasSetHide) {
            ModuleManager.hasHideMap = false;
            if (this.backData) {
                this.backData.dispose();
                this.backData = null;
            }
            if (this._shadow) {
                DisplayUtil.removeForParent(this._shadow);
            }
            LayerManager.showMap();
        }
    }

    public function hide():void {
        this.checkShowMap();
        DisplayUtil.removeForParent(this, false);
        if (Boolean(this._coverUI) && LayerManager.moduleLayer.contains(this._coverUI) == true) {
            DisplayUtil.removeForParent(this._coverUI, false);
        }
        SoundEffects.playBtnClick();
    }

    public function dispose():void {
        this.checkShowMap();
        DisplayUtil.removeForParent(this);
        if (Boolean(this._coverUI) && LayerManager.moduleLayer.contains(this._coverUI) == true) {
            DisplayUtil.removeForParent(this._coverUI);
        }
        this._coverUI = null;
        SoundEffects.playBtnClick();
    }

    protected function setMainUI(param1:MovieClip):void {
        this._mainUI = param1;
        addChild(this._mainUI);
        this._closeBtn = this._mainUI["closeBtn"] as SimpleButton;
        this._dragSprite = this._mainUI["dragMC"] as Sprite;
        this.initEventListener();
    }

    protected function onClose(param1:MouseEvent):void {
        ModuleManager.closeForInstance(this);
    }

    private function initEventListener():void {
        if (this._closeBtn != null) {
            this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        }
        if (this._dragSprite != null) {
            this._dragSprite.buttonMode = true;
            this._dragSprite.addEventListener(MouseEvent.MOUSE_DOWN, this.onDragStart);
            this._dragSprite.addEventListener(MouseEvent.MOUSE_UP, this.onDragEnd);
        }
    }

    private function onDragStart(param1:MouseEvent):void {
        DisplayObjectUtil.bringToTop(this);
        startDrag();
    }

    private function onDragEnd(param1:Event):void {
        stopDrag();
    }
}
}
