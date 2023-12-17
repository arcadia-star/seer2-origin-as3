package com.taomee.seer2.core.scene.events
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ModelLocator extends EventDispatcher
   {
      
      private static var _instance:ModelLocator = null;
       
      
      public function ModelLocator(param1:IEventDispatcher = null)
      {
         super();
         if(_instance)
         {
            throw new Error("事件中心只能存在一个");
         }
         _instance = this;
      }
      
      public static function getInstance() : ModelLocator
      {
         if(_instance == null)
         {
            _instance = new ModelLocator();
         }
         return _instance;
      }
      
      public function sendEvent(param1:Event) : void
      {
         dispatchEvent(param1);
      }
   }
}
