package com.taomee.seer2.core.net
{
   import com.taomee.seer2.core.net.message.Message;
   import flash.events.Event;
   
   public class MessageEvent extends Event
   {
       
      
      public var message:Message;
      
      public function MessageEvent(param1:String, param2:Message)
      {
         super(param1);
         this.message = param2;
      }
   }
}
