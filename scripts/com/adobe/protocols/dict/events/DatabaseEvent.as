package com.adobe.protocols.dict.events
{
   import flash.events.Event;
   
   public class DatabaseEvent extends Event
   {
      
      public static const DATABASES:String = "databases";
       
      
      private var _databases:Array;
      
      public function DatabaseEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set databases(param1:Array) : void
      {
         this._databases = param1;
      }
      
      public function get databases() : Array
      {
         return this._databases;
      }
      
      override public function clone() : Event
      {
         var _loc1_:DatabaseEvent = new DatabaseEvent(type,bubbles,cancelable);
         _loc1_.databases = this._databases;
         return _loc1_;
      }
   }
}
