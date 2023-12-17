package com.taomee.seer2.app.chat.panel
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.chat.constant.ChatPipeType;
   import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
   import com.taomee.seer2.app.chat.pipe.IChatPipe;
   import com.taomee.seer2.app.notify.NoticeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.EventDispatcher;
   
   public class ChatPanelPipe extends EventDispatcher implements IChatPipe
   {
       
      
      private var _type:int;
      
      public function ChatPanelPipe()
      {
         super();
         this._type = ChatPipeType.PRIVATE;
      }
      
      public function show(param1:uint, param2:Vector.<ChatReceivedMessage>) : void
      {
         var _loc3_:Object = {
            "userID":param1,
            "message":param2
         };
         ModuleManager.toggleModule(URLUtil.getAppModule("ChatPanel"),"正在打开聊天面板...",_loc3_,"_" + param1);
      }
      
      public function onMessage(param1:ChatReceivedMessage) : void
      {
         var _loc2_:uint = param1.senderId;
         var _loc3_:uint = param1.receiverId;
         if(_loc2_ == ActorManager.actorInfo.id)
         {
            if(this.isChatPanelShowing(_loc3_))
            {
               this.onPanelMessage(param1);
            }
         }
         else if(this.isChatPanelShowing(_loc2_))
         {
            this.onPanelMessage(param1);
         }
         else
         {
            this.onNoticeMessage(param1);
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
         NoticeManager.addChatNotice(param1.senderId,param1);
      }
      
      private function isChatPanelShowing(param1:uint) : Boolean
      {
         return ModuleManager.contains("ChatPanel","_" + param1);
      }
      
      private function dispatchMessageEvent(param1:String, param2:Vector.<ChatReceivedMessage>) : void
      {
         if(hasEventListener(param1))
         {
            dispatchEvent(new ChatPanelEvent(param1,param2));
         }
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
