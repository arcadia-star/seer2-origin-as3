package com.taomee.seer2.app.activity.events
{
   import flash.events.Event;
   
   public class ActivityTimeEvent extends Event
   {
      
      public static const ACTIVITY_INPROGRESS:String = "activityInProgress";
      
      public static const ACTIVITY_END:String = "activityEnd";
       
      
      public var activityID:uint;
      
      public function ActivityTimeEvent(param1:String, param2:uint, param3:Boolean = false, param4:Boolean = false)
      {
         this.activityID = param2;
         super(param1,param3,param4);
      }
   }
}
