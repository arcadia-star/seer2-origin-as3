package com.taomee.seer2.app.arena.animation.event
{
   import flash.events.Event;
   
   public class ArenaAnimationEvent extends Event
   {
      
      public static const EVT_END:String = "animationEnd";
       
      
      public function ArenaAnimationEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
