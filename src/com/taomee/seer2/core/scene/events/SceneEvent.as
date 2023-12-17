package com.taomee.seer2.core.scene.events
{
   import flash.events.Event;
   
   public class SceneEvent extends Event
   {
      
      public static const LOAD_ERROR:String = "loadError";
      
      public static const LOAD_COMPLETE:String = "loadComplete";
      
      public static const SWITCH_START:String = "switchStart";
      
      public static const SWITCH_ERROR:String = "switchError";
      
      public static const SWITCH_COMPLETE:String = "switchComplete";
      
      public static const MAP_COMPLETE:String = "mapComplete";
       
      
      public function SceneEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
