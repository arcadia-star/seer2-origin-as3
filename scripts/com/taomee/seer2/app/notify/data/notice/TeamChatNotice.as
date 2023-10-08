package com.taomee.seer2.app.notify.data.notice
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.chat.ChatManager;
   import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
   
   public class TeamChatNotice extends Notice
   {
       
      
      private var _messageVec:Vector.<ChatReceivedMessage>;
      
      public function TeamChatNotice()
      {
         super(NoticeType.TEAM_CHAT,ActorManager.actorInfo.id);
         this._messageVec = new Vector.<ChatReceivedMessage>();
      }
      
      public function addMessage(param1:ChatReceivedMessage) : void
      {
         var _loc2_:ChatReceivedMessage = null;
         if(this._messageVec.length)
         {
            _loc2_ = this._messageVec[this._messageVec.length - 1];
         }
         if(Boolean(_loc2_) && _loc2_.senderId == param1.senderId)
         {
            _loc2_.message += param1.message;
         }
         else
         {
            this._messageVec.push(param1);
         }
      }
      
      override public function process() : void
      {
         ChatManager.teamChatPipe.show(this._messageVec);
      }
   }
}
