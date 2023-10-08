package com.adobe.protocols.dict.events
{
   import flash.events.Event;
   
   public class DefinitionHeaderEvent extends Event
   {
      
      public static const DEFINITION_HEADER:String = "definitionHeader";
       
      
      private var _definitionCount:uint;
      
      public function DefinitionHeaderEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set definitionCount(param1:uint) : void
      {
         this._definitionCount = param1;
      }
      
      public function get definitionCount() : uint
      {
         return this._definitionCount;
      }
      
      override public function clone() : Event
      {
         var _loc1_:DefinitionHeaderEvent = new DefinitionHeaderEvent(type,bubbles,cancelable);
         _loc1_.definitionCount = this._definitionCount;
         return _loc1_;
      }
   }
}
