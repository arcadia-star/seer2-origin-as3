package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.MinorToolBar;
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   
   public class CopyWidgetClick implements IToolBarWidgetClick
   {
      
      public static const COPY:String = "copy";
       
      
      private var _widget:com.taomee.seer2.app.controls.widget.ToolBarWidget;
      
      public function CopyWidgetClick()
      {
         super();
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         this._widget.showNormal();
         SceneManager.changeScene(SceneType.LOBBY,1071);
         MinorToolBar.hideCopyShine();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_322);
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
