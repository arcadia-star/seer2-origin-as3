package com.taomee.seer2.core.scene.events
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ModelLocator extends EventDispatcher
   {
      
      private static var _instance:com.taomee.seer2.core.scene.events.ModelLocator = null;
       
      
      public function ModelLocator(param1:IEventDispatcher = null)
      {
         super();
         if(_instance)
         {
            throw new Error("事件中心只能存在一个");
         }
         _instance = this;
      }
      
      public static function getInstance() : com.taomee.seer2.core.scene.events.ModelLocator
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.core.scene.events.ModelLocator();
         }
         return _instance;
      }
      
      public function sendEvent(param1:Event) : void
      {
         dispatchEvent(param1);
      }
   }
}
