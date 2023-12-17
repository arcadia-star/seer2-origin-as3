package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class BuddyWidgetClick implements IToolBarWidgetClick
   {
      
      public static const BUDDY:String = "buddy";
       
      
      private var _widget:ToolBarWidget;
      
      public function BuddyWidgetClick()
      {
         super();
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_307);
         this._widget.showNormal();
         ModuleManager.toggleModule(URLUtil.getAppModule("BuddyListPanel"),"正在打开好友列表...");
         SoundEffects.playSoundMouseClick();
      }
      
      public function get widget() : ToolBarWidget
      {
         return this._widget;
      }
      
      public function set widget(param1:ToolBarWidget) : void
      {
         this._widget = param1;
      }
   }
}
