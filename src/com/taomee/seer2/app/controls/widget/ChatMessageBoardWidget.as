package com.taomee.seer2.app.controls.widget
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Expo;
   import com.taomee.seer2.app.chat.ChatManager;
   import com.taomee.seer2.app.chat.constant.ChatPipeType;
   import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
   import com.taomee.seer2.app.chat.pipe.IChatPipe;
   import com.taomee.seer2.app.controls.toolbar.chat.BoardContent;
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ChatMessageBoardWidget extends Sprite implements IChatPipe, IWidgetable
   {
      
      public static const CHAT_OUTPUT:String = "chatOutput";
       
      
      private var SHOW_Y_POS:Number = 137;
      
      private var HIDE_Y_POS:Number = 284;
      
      private var _mainUI:MovieClip;
      
      private var _toggleBtn:MovieClip;
      
      private var _chatContent:BoardContent;
      
      private var _background:MovieClip;
      
      private var _type:uint;
      
      private var _isShow:Boolean = false;
      
      public function ChatMessageBoardWidget(param1:MovieClip)
      {
         super();
         this._mainUI = param1;
         addChild(this._mainUI);
         this._type = ChatPipeType.PUBLIC;
         ChatManager.addPipe(this);
         this.initialize();
         this.hide();
         this.layIcon();
      }
      
      public function layIcon() : void
      {
      }
      
      private function initialize() : void
      {
         this.createChildren();
         this.initEventListener();
      }
      
      private function createChildren() : void
      {
         this._toggleBtn = this._mainUI["btnToggle"];
         SoundEffects.setArrow(this._toggleBtn);
         this._background = this._mainUI["mcBackground"];
         this._chatContent = new BoardContent(this._mainUI["chatTxt"]);
         this._mainUI.addChild(this._chatContent);
         this.onHideToggleOver();
      }
      
      private function initEventListener() : void
      {
         mouseEnabled = false;
         this._toggleBtn.addEventListener(MouseEvent.CLICK,this.onBoarToggle);
      }
      
      private function onBoarToggle(param1:MouseEvent) : void
      {
         if(this._isShow == true)
         {
            this._toggleBtn.gotoAndStop(1);
            this.hideContent();
            this.toggleEnable(false);
            TweenLite.to(this._mainUI,0.6,{
               "y":this.HIDE_Y_POS,
               "ease":Expo.easeOut,
               "onComplete":this.onHideToggleOver
            });
         }
         else
         {
            this._toggleBtn.gotoAndStop(2);
            this.toggleEnable(false);
            this._background.visible = true;
            TweenLite.to(this._mainUI,0.6,{
               "y":this.SHOW_Y_POS,
               "ease":Expo.easeOut,
               "onComplete":this.onShowToggleOver
            });
         }
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_303);
      }
      
      private function onHideToggleOver() : void
      {
         this.toggleEnable(true);
         this._isShow = false;
         this._background.visible = false;
      }
      
      private function onShowToggleOver() : void
      {
         this.toggleEnable(true);
         this._isShow = true;
         this.showContent();
      }
      
      private function toggleEnable(param1:Boolean) : void
      {
         this.mouseEnabled = param1;
         this.mouseChildren = param1;
      }
      
      private function showContent() : void
      {
         addChild(this._chatContent);
         this._chatContent.setPosition(this._mainUI.x,this._mainUI.y);
      }
      
      private function hideContent() : void
      {
         DisplayObjectUtil.removeFromParent(this._chatContent);
      }
      
      public function hide() : void
      {
         this._toggleBtn.gotoAndStop(1);
         this._background.visible = false;
         this.hideContent();
         this._mainUI.y = this.HIDE_Y_POS;
         this._isShow = false;
      }
      
      public function onMessage(param1:ChatReceivedMessage) : void
      {
         this._chatContent.appendMessage(param1);
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set type(param1:int) : void
      {
         this._type = param1;
      }
   }
}
