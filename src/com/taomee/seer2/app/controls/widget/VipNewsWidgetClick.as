package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.manager.VersionManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   
   public class VipNewsWidgetClick implements IToolBarWidgetClick
   {
      
      public static const VIPNEWS:String = "vipNews";
       
      
      private var _widget:ToolBarWidget;
      
      public function VipNewsWidgetClick()
      {
         super();
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_41);
         ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"),"正在vip面板...",{"currentTab":0});
         this.writeRecord();
      }
      
      private function writeRecord() : void
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.SEER_NEWS_VIP_BTN);
         _loc1_.data["newVipBtn"] = VersionManager.version;
         _loc1_.flush();
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
