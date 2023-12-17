package com.taomee.seer2.app.chat.events
{
   import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
   import flash.events.Event;
   
   public class TeamChatEvent extends Event
   {
      
      public static const MESSAGE:String = "message";
       
      
      private var _messageVec:Vector.<ChatReceivedMessage>;
      
      public function TeamChatEvent(param1:String, param2:Vector.<ChatReceivedMessage>, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._messageVec = param2;
      }
      
      public function get messageVec() : Vector.<ChatReceivedMessage>
      {
         return this._messageVec;
      }
   }
}
