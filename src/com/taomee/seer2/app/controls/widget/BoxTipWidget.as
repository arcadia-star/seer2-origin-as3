package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.app.processor.activity.meteorShopTips.MeteorShopTipsAct;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BoxTipWidget extends Sprite implements IWidgetable
   {
      
      public static const BOX_TIP:String = "boxTip";
       
      
      private var _mainUI:MovieClip;
      
      private var _btn:MovieClip;
      
      private var _mc:MovieClip;
      
      public function BoxTipWidget(param1:MovieClip)
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
      
      public function get mainUI() : MovieClip
      {
         return this._mainUI;
      }
      
      private function initEventListener() : void
      {
         this._mainUI.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         MeteorShopTipsAct.overTime = TimeManager.getServerTime() - 1;
         ModuleManager.showAppModule("MeteorShopPanel");
      }
      
      private function onOver(param1:MouseEvent) : void
      {
      }
      
      private function onOut(param1:MouseEvent) : void
      {
      }
   }
}
