package com.adobe.protocols.dict.events
{
   import com.adobe.protocols.dict.Definition;
   import flash.events.Event;
   
   public class DefinitionEvent extends Event
   {
      
      public static const DEFINITION:String = "definition";
       
      
      private var _definition:Definition;
      
      public function DefinitionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set definition(param1:Definition) : void
      {
         this._definition = param1;
      }
      
      public function get definition() : Definition
      {
         return this._definition;
      }
      
      override public function clone() : Event
      {
         var _loc1_:DefinitionEvent = new DefinitionEvent(type,bubbles,cancelable);
         _loc1_.definition = this._definition;
         return _loc1_;
      }
   }
}
