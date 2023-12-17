package com.taomee.seer2.app.controls.toolbar.emotion
{
   import com.taomee.seer2.app.chat.data.ChatSendMessage;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.effects.MotionEffects;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class EmotionSelectPanel extends Sprite
   {
      
      public static const EMOTION_NUM:int = 24;
       
      
      private var _ui:MovieClip;
      
      private var _isShow:Boolean;
      
      protected var _selectedEmotionId:String;
      
      public function EmotionSelectPanel()
      {
         var _loc2_:MovieClip = null;
         super();
         this._ui = UIManager.getMovieClip("UI_EmotionSelectPanelUI");
         var _loc1_:int = 0;
         while(_loc1_ < EMOTION_NUM)
         {
            _loc2_ = this._ui["face" + _loc1_];
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.onEmotionOver);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.onEmotionOut);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onBtnClick);
            _loc1_++;
         }
         addChild(this._ui);
      }
      
      private function onEmotionOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         MotionEffects.execElastic(_loc2_);
      }
      
      private function onEmotionOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         MotionEffects.resetScale(_loc2_);
      }
      
      protected function onBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         this._selectedEmotionId = _loc2_.name.substring(4);
         var _loc3_:* = "[e_" + this._selectedEmotionId + "]";
         var _loc4_:ChatSendMessage = new ChatSendMessage(0,_loc3_);
         Connection.send(CommandSet.CHAT_1102,_loc4_.pack());
         this.hide();
      }
      
      public function toggle() : void
      {
         this._isShow = !this._isShow;
         this.visible = this._isShow;
      }
      
      public function hide() : void
      {
         this._isShow = true;
         this.toggle();
      }
   }
}
