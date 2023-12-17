package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.shoot.ShootGridPanel;
   import com.taomee.seer2.core.effects.SoundEffects;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class HeaderShootWidgetClick implements IToolBarWidgetClick
   {
      
      public static const SHOOT:String = "shot";
       
      
      private var _widget:ToolBarWidget;
      
      public function HeaderShootWidgetClick()
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
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_305);
         if(ShootGridPanel.isShow)
         {
            ShootGridPanel.instance.hide();
         }
         else
         {
            ShootGridPanel.instance.show(param1.currentTarget as DisplayObject);
         }
         SoundEffects.playSoundMouseClick();
      }
   }
}
