package com.taomee.seer2.app.notify.events
{
   import flash.events.Event;
   
   public class NotifyEvent extends Event
   {
      
      public static const BUDDY_NOTIFY:String = "buddyNotify";
       
      
      public function NotifyEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
