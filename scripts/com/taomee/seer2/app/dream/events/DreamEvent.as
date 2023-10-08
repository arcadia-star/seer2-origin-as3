package com.taomee.seer2.app.dream.events
{
   import flash.events.Event;
   
   public class DreamEvent extends Event
   {
      
      public static const DREAM_FIGHT_MONSTER_START:String = "dreamFightMonsterStart";
      
      public static const ENTER_DREAM:String = "enterDream";
       
      
      public function DreamEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
