package com.taomee.seer2.app.controls.widget
{
   import com.taomee.analytics.Analytics;
   import com.taomee.seer2.app.chat.data.ChatSendMessage;
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import org.taomee.utils.StringUtil;
   
   public class ChatInputFrameWidget extends Sprite implements IWidgetable
   {
      
      public static const CHAT_INPUT:String = "chatInput";
       
      
      private var _mainUI:MovieClip;
      
      private var _sendMsgBtn:SimpleButton;
      
      private var _msgInputTxt:TextField;
      
      public function ChatInputFrameWidget(param1:MovieClip)
      {
         super();
         this._mainUI = param1;
         addChild(this._mainUI);
         this._sendMsgBtn = this._mainUI["btnSend"];
         this._msgInputTxt = this._mainUI["txtInput"];
         this.initEventListener();
      }
      
      private function initEventListener() : void
      {
         this._msgInputTxt.addEventListener(FocusEvent.FOCUS_IN,this.inFocusInput);
         this._msgInputTxt.addEventListener(FocusEvent.FOCUS_OUT,this.outFocusInput);
         this._sendMsgBtn.addEventListener(MouseEvent.CLICK,this.onMessageSend);
      }
      
      private function inFocusInput(param1:FocusEvent) : void
      {
         LayerManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function outFocusInput(param1:FocusEvent) : void
      {
         LayerManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.onMessageSend();
         }
      }
      
      private function onMessageSend(param1:MouseEvent = null) : void
      {
         var _loc3_:ChatSendMessage = null;
         var _loc2_:String = String(StringUtil.trim(this._msgInputTxt.text));
         if(_loc2_ == "")
         {
            return;
         }
         if(_loc2_.charAt(0) == "#")
         {
            if(ClientConfig.isLocal)
            {
               ModuleManager.showModule(URLUtil.getAppModule(_loc2_.substring(1)),"Rock在召唤面板");
               this.clear();
            }
            return;
         }
         if(this.checkAnalyticsBackdoor() == false)
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_9);
            _loc3_ = new ChatSendMessage(0,this._msgInputTxt.text);
            Connection.send(CommandSet.CHAT_1102,_loc3_.pack());
         }
         this.clear();
      }
      
      private function checkAnalyticsBackdoor() : Boolean
      {
         var _loc1_:String = String(StringUtil.trim(this._msgInputTxt.text));
         if(_loc1_ == "#Analytics.show")
         {
            Analytics.init(3,"http://seer2.61.com",LayerManager.stage);
            Analytics.show(300,0);
            return true;
         }
         if(_loc1_ == "#Analytics.hide")
         {
            Analytics.hide();
            return true;
         }
         return false;
      }
      
      public function clear() : void
      {
         this._msgInputTxt.text = "";
      }
   }
}
