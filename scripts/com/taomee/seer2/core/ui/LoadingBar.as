package com.taomee.seer2.core.ui
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import org.taomee.utils.AlignType;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class LoadingBar
   {
      
      private static var _titleDataClass:Class = LoadingBar__titleDataClass;
      
      private static var _titleDataXml:XML;
      
      private static const TITLE_INTERVAL:int = 2000;
      
      private static var _instance:com.taomee.seer2.core.ui.LoadingBar;
      
      {
         initialize();
      }
      
      private var _container:Sprite;
      
      private var _progressPet:MovieClip;
      
      private var _titleIndex:int;
      
      private var _progressBar:MovieClip;
      
      private var _coverUI:Sprite;
      
      public function LoadingBar()
      {
         super();
         this._container = new UI_LoadingBar();
         this._progressPet = this._container["progressPet"];
         this._progressBar = this._container["progressBar"];
         this._coverUI = this._container["cover"];
         this._progressPet.gotoAndStop(1);
         this._progressBar.scaleX = 0;
         this._container.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._container.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         LayerManager.stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize(null);
      }
      
      private static function initialize() : void
      {
         _titleDataXml = XML(new _titleDataClass());
         var _loc1_:XMLList = _titleDataXml.elements("title");
      }
      
      public static function show(param1:String = "") : void
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.core.ui.LoadingBar();
         }
         _instance.show(LayerManager.topLayer,true,LayerManager.root.stage.stageWidth,LayerManager.root.stage.stageHeight);
      }
      
      public static function progress(param1:Number) : void
      {
         if(_instance)
         {
            _instance.precent = param1;
         }
      }
      
      public static function hide() : void
      {
         if(_instance)
         {
            _instance.hide();
         }
      }
      
      private function onResize(param1:Event) : void
      {
         if(this._container)
         {
            this._container.scaleX = LayerManager.stage.stageWidth / 1200;
            this._container.scaleY = LayerManager.stage.stageHeight / 660;
         }
      }
      
      public function dispose() : void
      {
         this.hide();
         Tick.instance.removeRender(this.onTitleTimer);
         this._container.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._container.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this._progressPet = null;
         this._progressBar = null;
         this._container = null;
         this._coverUI = null;
      }
      
      public function show(param1:DisplayObjectContainer, param2:Boolean = false, param3:Number = NaN, param4:Number = NaN) : void
      {
         this._progressPet.gotoAndStop(1);
         this._progressBar.scaleX = 0;
         param1.addChild(this._container);
         if(param2)
         {
            if(this._container.contains(this._coverUI) == false)
            {
               if(!isNaN(param3))
               {
                  this._coverUI.width = param3;
               }
               if(!isNaN(param4))
               {
                  this._coverUI.height = param4;
               }
               this._container.addChildAt(this._coverUI,0);
            }
         }
         else
         {
            DisplayUtil.removeForParent(this._coverUI,false);
         }
         if(isNaN(param3))
         {
            param3 = LayerManager.root.width;
         }
         if(isNaN(param4))
         {
            param4 = LayerManager.root.height;
         }
         DisplayUtil.align(this._container,AlignType.MIDDLE_CENTER,new Rectangle(0,0,param3,param4));
      }
      
      public function hide() : void
      {
         DisplayUtil.removeForParent(this._container);
      }
      
      public function set precent(param1:Number) : void
      {
         var _loc2_:int = Math.ceil(param1 * this._progressPet.totalFrames);
         this._progressPet.gotoAndStop(_loc2_);
         this._progressBar.scaleX = _loc2_ / 100;
      }
      
      private function onTitleTimer(param1:int) : void
      {
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this._titleIndex = 0;
         Tick.instance.addRender(this.onTitleTimer,TITLE_INTERVAL);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         Tick.instance.removeRender(this.onTitleTimer);
      }
   }
}
