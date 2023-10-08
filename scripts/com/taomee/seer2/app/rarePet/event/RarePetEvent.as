package com.taomee.seer2.app.rarePet.event
{
   import flash.events.Event;
   
   public class RarePetEvent extends Event
   {
      
      public static const START_TIME_UP:String = "startTimeUp";
      
      public static const END_TIME_UP:String = "endTimeUp";
       
      
      private var _rarePetId:int;
      
      public function RarePetEvent(param1:String, param2:int)
      {
         this._rarePetId = param2;
         super(param1,false,false);
      }
      
      public function get rarePetId() : int
      {
         return this._rarePetId;
      }
   }
}
