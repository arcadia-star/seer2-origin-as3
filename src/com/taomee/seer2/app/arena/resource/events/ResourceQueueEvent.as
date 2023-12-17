package com.taomee.seer2.app.arena.resource.events
{
   import flash.events.Event;
   
   public class ResourceQueueEvent extends Event
   {
      
      public static const ITEM_COMPLETE:String = "itemComplete";
      
      public static const ITEM_ERROR:String = "itemError";
      
      public static const QUEUE_START:String = "queueStart";
      
      public static const QUEUE_ERROR:String = "queueError";
      
      public static const QUEUE_COMPLETE:String = "queueComplete";
       
      
      public function ResourceQueueEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
