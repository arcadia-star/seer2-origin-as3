package com.adobe.protocols.dict.events
{
   import flash.events.Event;
   
   public class NoMatchEvent extends Event
   {
      
      public static const NO_MATCH:String = "noMatch";
       
      
      public function NoMatchEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new NoMatchEvent(type,bubbles,cancelable);
      }
   }
}
