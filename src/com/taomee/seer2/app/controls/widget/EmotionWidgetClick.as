package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.toolbar.emotion.EmotionSelectPanel;
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.effects.SoundEffects;
   import flash.events.MouseEvent;
   
   public class EmotionWidgetClick implements IToolBarWidgetClick
   {
      
      public static const EMOTION:String = "emotion";
       
      
      private var _widget:ToolBarWidget;
      
      private var _emotionPanel:EmotionSelectPanel;
      
      public function EmotionWidgetClick(param1:EmotionSelectPanel)
      {
         super();
         this._emotionPanel = param1;
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_304);
         this._emotionPanel.toggle();
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
