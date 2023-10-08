package com.taomee.seer2.module.login.net
{
   import flash.events.Event;
   
   public class MessageEvent extends Event
   {
       
      
      public var message:com.taomee.seer2.module.login.net.Message;
      
      public function MessageEvent(param1:String, param2:com.taomee.seer2.module.login.net.Message)
      {
         this.message = param2;
         super(param1,false,false);
      }
   }
}
