package com.adobe.protocols.dict.events
{
   import flash.events.Event;
   
   public class DictionaryServerEvent extends Event
   {
      
      public static const SERVERS:String = "servers";
       
      
      private var _servers:Array;
      
      public function DictionaryServerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set servers(param1:Array) : void
      {
         this._servers = param1;
      }
      
      public function get servers() : Array
      {
         return this._servers;
      }
      
      override public function clone() : Event
      {
         var _loc1_:DictionaryServerEvent = new DictionaryServerEvent(type,bubbles,cancelable);
         _loc1_.servers = this._servers;
         return _loc1_;
      }
   }
}
