package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class Broad0WidgetClick extends Sprite implements IWidgetable
   {
      
      public static const BROAD_CAST_ONE:String = "Broad_0";
       
      
      private var _mainUI:MovieClip;
      
      private var _btn:MovieClip;
      
      private var _mc:MovieClip;
      
      public function Broad0WidgetClick(param1:MovieClip)
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
         navigateToURL(new URLRequest("http://as.61.com/events/aslr/?tad=innermedia.seer2.free.seer2icon"));
      }
   }
}
