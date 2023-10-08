package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestWidgetClick implements IToolBarWidgetClick
   {
      
      public static const QUEST:String = "quest";
       
      
      private var _widget:com.taomee.seer2.app.controls.widget.ToolBarWidget;
      
      public function QuestWidgetClick()
      {
         super();
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_320);
         this._widget.showNormal();
         ModuleManager.toggleModule(URLUtil.getAppModule("QuestPanel"),"正在打开任务面板...");
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
