package com.adobe.protocols.dict.events
{
   import flash.events.Event;
   
   public class DisconnectedEvent extends Event
   {
      
      public static const DISCONNECTED:String = "disconnected";
       
      
      public function DisconnectedEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new DisconnectedEvent(type,bubbles,cancelable);
      }
   }
}
