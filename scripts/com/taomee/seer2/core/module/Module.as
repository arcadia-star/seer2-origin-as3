package com.taomee.seer2.core.module
{
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
   
   public class Module extends Sprite
   {
       
      
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
      
      public function Module()
      {
         super();
      }
      
      public function set hideMap(param1:Boolean) : void
      {
         this._hideMap = param1;
      }
      
      public function get lifecycleType() : String
      {
         return this._lifecycleType;
      }
      
      public function setIsAlign() : void
      {
         this._isAlign = true;
      }
      
      public function setIsAlignContent() : void
      {
         this._isAlignContent = true;
      }
      
      public function setup() : void
      {
      }
      
      public function init(param1:Object) : void
      {
      }
      
      public function show() : void
      {
         this.setBackGround();
         LayerManager.moduleLayer.addChild(this);
         this.setCoverUI();
         if(this._isAlignContent == false)
         {
            DisplayUtil.align(this,4,this._rootRect,this._offset);
         }
         if(this._isAlign == false)
         {
            this._setTimeout = setTimeout(this.align,100);
            TweenLite.from(this,0.3,{"alpha":0});
         }
         else
         {
            this.align();
         }
      }
      
      protected function setCoverUI() : void
      {
         if(this._cover)
         {
            if(this._coverUI == null)
            {
               this._coverUI = new UI_ScreenCover();
               this._coverUI.cacheAsBitmap = true;
            }
            if(LayerManager.moduleLayer.contains(this._coverUI) == false)
            {
               LayerManager.moduleLayer.addChildAt(this._coverUI,0);
            }
         }
      }
      
      public function align() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this._rootRect = new Rectangle(0,0,this.WINDOW_W,this.WINDOW_H);
         if(this._isAlignContent == false)
         {
            DisplayUtil.align(this,4,this._rootRect,this._offset);
         }
         if(this.width >= this.WINDOW_W)
         {
            _loc1_ = LayerManager.stage.stageWidth <= 960 ? 960 : LayerManager.stage.stageWidth;
            _loc2_ = LayerManager.stage.stageHeight <= 560 ? 560 : LayerManager.stage.stageHeight;
         }
         else
         {
            _loc1_ = LayerManager.stage.stageWidth < this.width ? int(this.width) : LayerManager.stage.stageWidth;
            _loc2_ = LayerManager.stage.stageHeight < this.height ? int(this.height) : LayerManager.stage.stageHeight;
         }
         this.x += (_loc1_ - this.WINDOW_W) / 2;
         this.y += (_loc2_ - this.WINDOW_H) / 2;
      }
      
      protected function setBackGround() : void
      {
         this.hasSetHide = false;
         if(this._hideMap && !ModuleManager.hasHideMap)
         {
            ModuleManager.hasHideMap = this.hasSetHide = true;
            this.backGround = new Bitmap();
            this.backData = new BitmapData(this.WINDOW_W,this.WINDOW_H,false,4278190080);
            this.backData.draw(LayerManager.stage);
            this.backGround.bitmapData = this.backData;
            LayerManager.moduleLayer.addChild(this.backGround);
            this.createShadow();
            LayerManager.hideMap();
         }
      }
      
      private function createShadow() : void
      {
         if(!this._shadow)
         {
            this._shadow = new Shape();
            this._shadow.graphics.beginFill(0,0.8);
            this._shadow.graphics.drawRect(0,0,this.WINDOW_W,this.WINDOW_H);
            this._shadow.graphics.endFill();
         }
         LayerManager.moduleLayer.addChild(this._shadow);
      }
      
      private function checkShowMap() : void
      {
         if(ModuleManager.hasHideMap && this.hasSetHide)
         {
            ModuleManager.hasHideMap = false;
            if(this.backData)
            {
               this.backData.dispose();
               this.backData = null;
            }
            if(this._shadow)
            {
               DisplayUtil.removeForParent(this._shadow);
            }
            LayerManager.showMap();
         }
      }
      
      public function hide() : void
      {
         this.checkShowMap();
         DisplayUtil.removeForParent(this,false);
         if(Boolean(this._coverUI) && LayerManager.moduleLayer.contains(this._coverUI) == true)
         {
            DisplayUtil.removeForParent(this._coverUI,false);
         }
         SoundEffects.playBtnClick();
      }
      
      public function dispose() : void
      {
         this.checkShowMap();
         DisplayUtil.removeForParent(this);
         if(Boolean(this._coverUI) && LayerManager.moduleLayer.contains(this._coverUI) == true)
         {
            DisplayUtil.removeForParent(this._coverUI);
         }
         this._coverUI = null;
         SoundEffects.playBtnClick();
      }
      
      protected function setMainUI(param1:MovieClip) : void
      {
         this._mainUI = param1;
         addChild(this._mainUI);
         this._closeBtn = this._mainUI["closeBtn"] as SimpleButton;
         this._dragSprite = this._mainUI["dragMC"] as Sprite;
         this.initEventListener();
      }
      
      protected function onClose(param1:MouseEvent) : void
      {
         ModuleManager.closeForInstance(this);
      }
      
      private function initEventListener() : void
      {
         if(this._closeBtn != null)
         {
            this._closeBtn.addEventListener(MouseEvent.CLICK,this.onClose);
         }
         if(this._dragSprite != null)
         {
            this._dragSprite.buttonMode = true;
            this._dragSprite.addEventListener(MouseEvent.MOUSE_DOWN,this.onDragStart);
            this._dragSprite.addEventListener(MouseEvent.MOUSE_UP,this.onDragEnd);
         }
      }
      
      private function onDragStart(param1:MouseEvent) : void
      {
         DisplayObjectUtil.bringToTop(this);
         startDrag();
      }
      
      private function onDragEnd(param1:Event) : void
      {
         stopDrag();
      }
   }
}
