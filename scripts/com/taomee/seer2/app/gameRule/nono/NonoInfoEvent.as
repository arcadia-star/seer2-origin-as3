package com.taomee.seer2.app.gameRule.nono
{
   import flash.events.Event;
   
   public class NonoInfoEvent extends Event
   {
      
      public static const NONO_FLAG_CHANGE:String = "NONO_FLAG_CHANGE";
      
      public static const NONOINFO_UPDATE:String = "NONOINFO_UPDATE";
      
      public static const NONO_TIMER:String = "NONO_TIMER";
      
      public static const NONO_TIMER_COMPLETE:String = "NONO_TIMER_COMPLETE";
       
      
      public var seconds:uint = 0;
      
      public function NonoInfoEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:NonoInfoEvent = new NonoInfoEvent(type,bubbles,cancelable);
         _loc1_.seconds = this.seconds;
         return _loc1_;
      }
   }
}
