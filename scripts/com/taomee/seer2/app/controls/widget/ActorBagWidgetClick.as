package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class ActorBagWidgetClick implements IToolBarWidgetClick
   {
      
      public static const ACTOR_BAG:String = "actorBag";
       
      
      private var _widget:com.taomee.seer2.app.controls.widget.ToolBarWidget;
      
      public function ActorBagWidgetClick()
      {
         super();
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         this._widget.showNormal();
         ModuleManager.toggleModule(URLUtil.getAppModule("ItemBagPanel"),"正在打开背包面板...");
         SoundEffects.playSoundMouseClick();
      }
      
      public function get widget() : com.taomee.seer2.app.controls.widget.ToolBarWidget
      {
         return this._widget;
      }
      
      public function set widget(param1:com.taomee.seer2.app.controls.widget.ToolBarWidget) : void
      {
         this._widget = param1;
      }
   }
}
