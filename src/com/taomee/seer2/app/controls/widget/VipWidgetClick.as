package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class VipWidgetClick implements IToolBarWidgetClick
   {
      
      public static const VIP:String = "vip";
       
      
      private var _widget:ToolBarWidget;
      
      public function VipWidgetClick()
      {
         super();
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_17);
         ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"),"正在vip面板...",{"currentTab":0});
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
