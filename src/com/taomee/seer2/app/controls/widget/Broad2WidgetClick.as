package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.core.module.ModuleManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Broad2WidgetClick extends Sprite implements IWidgetable
   {
      
      public static const BROAD_CAST_THREE:String = "Broad_2";
       
      
      private var _mainUI:MovieClip;
      
      private var _btn:MovieClip;
      
      private var _mc:MovieClip;
      
      public function Broad2WidgetClick(param1:MovieClip)
      {
         super();
         this._mainUI = param1;
         addChild(this._mainUI);
         this.initMC();
         this.initEventListener();
      }
      
      private function initMC() : void
      {
         this._mainUI.buttonMode = true;
      }
      
      private function initEventListener() : void
      {
         this._mainUI.addEventListener(MouseEvent.CLICK,this.onWidgetClick);
      }
      
      private function onWidgetClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("BroadCastTwoPanel");
      }
   }
}
