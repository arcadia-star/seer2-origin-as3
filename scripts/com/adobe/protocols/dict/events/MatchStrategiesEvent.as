package com.adobe.protocols.dict.events
{
   import flash.events.Event;
   
   public class MatchStrategiesEvent extends Event
   {
      
      public static const MATCH_STRATEGIES:String = "matchStrategies";
       
      
      private var _strategies:Array;
      
      public function MatchStrategiesEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set strategies(param1:Array) : void
      {
         this._strategies = param1;
      }
      
      public function get strategies() : Array
      {
         return this._strategies;
      }
      
      override public function clone() : Event
      {
         var _loc1_:MatchStrategiesEvent = new MatchStrategiesEvent(type,bubbles,cancelable);
         _loc1_.strategies = this._strategies;
         return _loc1_;
      }
   }
}
