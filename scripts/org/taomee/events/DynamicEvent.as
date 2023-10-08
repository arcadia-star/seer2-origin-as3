package org.taomee.events
{
   import flash.events.Event;
   
   public class DynamicEvent extends Event
   {
       
      
      private var _paramObject;
      
      public function DynamicEvent(param1:String, param2:* = null)
      {
         super(param1,false,false);
         _paramObject = param2;
      }
      
      public function get paramObject() : *
      {
         return _paramObject;
      }
      
      override public function clone() : Event
      {
         return new DynamicEvent(type,_paramObject);
      }
   }
}
