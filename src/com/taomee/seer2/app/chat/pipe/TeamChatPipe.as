package com.taomee.seer2.app.chat.pipe
{
   import com.taomee.seer2.app.chat.constant.ChatPipeType;
   import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
   import com.taomee.seer2.app.chat.events.TeamChatEvent;
   import com.taomee.seer2.app.notify.NoticeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.module.ModuleProxy;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.EventDispatcher;
   
   public class TeamChatPipe extends EventDispatcher implements IChatPipe
   {
       
      
      private var _type:int;
      
      private var _isPreventMessage:Boolean = false;
      
      public function TeamChatPipe()
      {
         super();
         this._type = ChatPipeType.TEAM;
      }
      
      public function show(param1:Vector.<ChatReceivedMessage>) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("TeamChatPanel"),"正在打开战队聊天面板...",{"message":param1});
      }
      
      public function onMessage(param1:ChatReceivedMessage) : void
      {
         if(this._isPreventMessage == false)
         {
            if(this.isTeamChatPanelShowing())
            {
               this.onPanelMessage(param1);
            }
            else
            {
               this.onNoticeMessage(param1);
            }
         }
      }
      
      private function onPanelMessage(param1:ChatReceivedMessage) : void
      {
         var _loc2_:Vector.<ChatReceivedMessage> = new Vector.<ChatReceivedMessage>();
         _loc2_.push(param1);
         this.dispatchMessageEvent("message",_loc2_);
      }
      
      private function onNoticeMessage(param1:ChatReceivedMessage) : void
      {
         NoticeManager.addTeamChatNotice(param1);
      }
      
      private function isTeamChatPanelShowing() : Boolean
      {
         return ModuleManager.getModuleStatus("TeamChatPanel") == ModuleProxy.SHOW ? true : false;
      }
      
      private function dispatchMessageEvent(param1:String, param2:Vector.<ChatReceivedMessage>) : void
      {
         if(hasEventListener(param1))
         {
            dispatchEvent(new TeamChatEvent(param1,param2));
         }
      }
      
      public function set isPreventMessage(param1:Boolean) : void
      {
         this._isPreventMessage = param1;
      }
      
      public function set type(param1:int) : void
      {
         this._type = param1;
      }
      
      public function get type() : int
      {
         return this._type;
      }
   }
}
