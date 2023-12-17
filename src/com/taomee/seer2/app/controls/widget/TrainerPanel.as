package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class TrainerPanel implements IToolBarWidgetClick
   {
      
      public static const Trainer:String = "trainer";
       
      
      private var _widget:ToolBarWidget;
      
      public function TrainerPanel()
      {
         super();
      }
      
      public function get widget() : ToolBarWidget
      {
         return this._widget;
      }
      
      public function set widget(param1:ToolBarWidget) : void
      {
         this._widget = param1;
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("TrainerPanel"),"正在打开训练师面板...");
      }
   }
}
