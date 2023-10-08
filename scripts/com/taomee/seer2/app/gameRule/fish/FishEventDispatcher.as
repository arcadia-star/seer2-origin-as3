package com.taomee.seer2.app.gameRule.fish
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class FishEventDispatcher extends EventDispatcher
   {
      
      private static var _instance:com.taomee.seer2.app.gameRule.fish.FishEventDispatcher;
       
      
      public function FishEventDispatcher(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function getInstance() : com.taomee.seer2.app.gameRule.fish.FishEventDispatcher
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.gameRule.fish.FishEventDispatcher();
         }
         return _instance;
      }
   }
}
