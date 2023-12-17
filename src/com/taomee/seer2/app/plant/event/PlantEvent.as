package com.taomee.seer2.app.plant.event
{
   import flash.events.Event;
   
   public class PlantEvent extends Event
   {
      
      public static const SELECT_ITEM:String = "selectItem";
      
      public static const SEED_STATUS_CHANGE:String = "seedStatusChange";
      
      public static const SELECT_TAB:String = "selectTab";
      
      public static const LIBRARY_CHANGE:String = "libraryChange";
       
      
      public var content:*;
      
      public var status:*;
      
      public function PlantEvent(param1:String, param2:*, param3:* = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.content = param2;
         this.status = param3;
      }
   }
}
