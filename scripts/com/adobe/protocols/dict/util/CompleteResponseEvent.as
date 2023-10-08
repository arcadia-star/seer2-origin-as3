package com.adobe.protocols.dict.util
{
   import flash.events.Event;
   
   public class CompleteResponseEvent extends Event
   {
      
      public static const COMPLETE_RESPONSE:String = "completeResponse";
       
      
      private var _response:String;
      
      public function CompleteResponseEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set response(param1:String) : void
      {
         this._response = param1;
      }
      
      public function get response() : String
      {
         return this._response;
      }
      
      override public function clone() : Event
      {
         var _loc1_:CompleteResponseEvent = new CompleteResponseEvent(type,bubbles,cancelable);
         _loc1_.response = this._response;
         return _loc1_;
      }
   }
}
