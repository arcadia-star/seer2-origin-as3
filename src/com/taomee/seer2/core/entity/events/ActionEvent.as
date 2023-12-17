package com.taomee.seer2.core.entity.events
{
   import flash.events.Event;
   
   public class ActionEvent extends Event
   {
      
      public static const START:String = "start";
      
      public static const FINISHED:String = "finished";
       
      
      public function ActionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
