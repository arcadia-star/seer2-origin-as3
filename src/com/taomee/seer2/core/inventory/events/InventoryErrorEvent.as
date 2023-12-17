package com.taomee.seer2.core.inventory.events
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   
   public class InventoryErrorEvent extends ErrorEvent
   {
      
      public static const FULL:String = "full";
      
      public static const QUANTITY_LIMIT_REACH:String = "quantityLimitReach";
      
      public static const NO_SUCH_ITEM:String = "noSuchItem";
       
      
      public function InventoryErrorEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = "")
      {
         super(param1,param2,param3,param4);
      }
      
      override public function clone() : Event
      {
         return new InventoryErrorEvent(this.type);
      }
   }
}
