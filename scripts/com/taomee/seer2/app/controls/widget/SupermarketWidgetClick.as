package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class SupermarketWidgetClick implements IToolBarWidgetClick
   {
      
      public static const SUPERMARKET:String = "supermarket";
       
      
      public function SupermarketWidgetClick()
      {
         super();
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_36);
         ModuleManager.toggleModule(URLUtil.getAppModule("ShopPanel"),"正在打开商城...");
      }
      
      public function get widget() : ToolBarWidget
      {
         return null;
      }
      
      public function set widget(param1:ToolBarWidget) : void
      {
      }
   }
}
