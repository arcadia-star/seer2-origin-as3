package com.taomee.seer2.app.controls.widget.core
{
   import com.taomee.seer2.app.controls.widget.ToolBarWidget;
   import flash.events.MouseEvent;
   
   public interface IToolBarWidgetClick extends IWidgetable
   {
       
      
      function onWidgetClick(param1:MouseEvent) : void;
      
      function get widget() : ToolBarWidget;
      
      function set widget(param1:ToolBarWidget) : void;
   }
}
