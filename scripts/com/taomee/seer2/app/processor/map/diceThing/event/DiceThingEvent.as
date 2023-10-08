package com.taomee.seer2.app.processor.map.diceThing.event
{
   import flash.events.Event;
   
   public class DiceThingEvent extends Event
   {
      
      public static const DICE_THING_OVER:String = "thing_over";
       
      
      private var _resultInfo:com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEventInfo;
      
      public function DiceThingEvent(param1:String, param2:com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEventInfo = null, param3:Boolean = false, param4:Boolean = false)
      {
         this._resultInfo = param2;
         super(param1,param3,param4);
      }
      
      public function get resultInfo() : com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEventInfo
      {
         return this._resultInfo;
      }
   }
}
