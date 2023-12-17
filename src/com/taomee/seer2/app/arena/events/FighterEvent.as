package com.taomee.seer2.app.arena.events
{
   import flash.events.Event;
   
   public class FighterEvent extends Event
   {
      
      public static const ACTION_START:String = "actionStart";
      
      public static const ACTION_END:String = "actionEnd";
      
      public static const REPORT_STATUS:String = "reportStatus";
      
      public static const HIT:String = "sexHit";
       
      
      private var _info:String;
      
      public function FighterEvent(param1:String, param2:String = null, param3:Boolean = false, param4:Boolean = false)
      {
         this._info = param2;
         super(param1,param3,param4);
      }
      
      public function get info() : String
      {
         return this._info;
      }
   }
}
