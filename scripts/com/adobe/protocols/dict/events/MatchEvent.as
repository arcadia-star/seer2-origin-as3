package com.adobe.protocols.dict.events
{
   import flash.events.Event;
   
   public class MatchEvent extends Event
   {
      
      public static const MATCH:String = "match";
       
      
      private var _matches:Array;
      
      public function MatchEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set matches(param1:Array) : void
      {
         this._matches = param1;
      }
      
      public function get matches() : Array
      {
         return this._matches;
      }
      
      override public function clone() : Event
      {
         var _loc1_:MatchEvent = new MatchEvent(type,bubbles,cancelable);
         _loc1_.matches = this._matches;
         return _loc1_;
      }
   }
}
