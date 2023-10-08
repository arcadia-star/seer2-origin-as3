package com.taomee.seer2.app.chat.events
{
   import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
   import flash.events.Event;
   
   public class PublicChatEvent extends Event
   {
      
      public static const MESSAGE:String = "message";
       
      
      private var _message:ChatReceivedMessage;
      
      public function PublicChatEvent(param1:String, param2:ChatReceivedMessage, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._message = param2;
      }
      
      public function get message() : ChatReceivedMessage
      {
         return this._message;
      }
   }
}
