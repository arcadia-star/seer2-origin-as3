package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.core.scene.ImageLevelManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SystemWidgetClick extends Sprite implements IWidgetable
   {
      
      public static const SYSTEM_WIDGET:String = "SYSTEM_WIDGET";
       
      
      private var _mainUI:MovieClip;
      
      private var _btn:MovieClip;
      
      private var _mc:MovieClip;
      
      public function SystemWidgetClick(param1:MovieClip)
      {
         super();
         this._mainUI = param1;
         addChild(this._mainUI);
         this.initMC();
         this.initEventListener();
      }
      
      private function initMC() : void
      {
         this._btn = this._mainUI["btn"];
         this._btn.buttonMode = true;
         this._btn.gotoAndStop(1);
      }
      
      private function initEventListener() : void
      {
         this._mainUI.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ImageLevelManager.showImagePanel();
      }
      
      private function onOver(param1:MouseEvent) : void
      {
      }
      
      private function onOut(param1:MouseEvent) : void
      {
      }
   }
}
