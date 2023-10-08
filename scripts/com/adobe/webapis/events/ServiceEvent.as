package com.adobe.webapis.events
{
   import flash.events.Event;
   
   public class ServiceEvent extends Event
   {
       
      
      private var _data:Object;
      
      public function ServiceEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         this._data = new Object();
         super(param1,param2,param3);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      override public function clone() : Event
      {
         var _loc1_:ServiceEvent = new ServiceEvent(type,bubbles,cancelable);
         _loc1_.data = this.data;
         return _loc1_;
      }
   }
}
