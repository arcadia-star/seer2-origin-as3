package com.taomee.seer2.app.arena.processor
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.controller.IArenaUIController;
   import com.taomee.seer2.app.arena.controller.IFightController;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class ArenaProcessor
   {
       
      
      protected var _secne:ArenaScene;
      
      public function ArenaProcessor(param1:ArenaScene)
      {
         super();
         this._secne = param1;
         this.init();
      }
      
      public function init() : void
      {
      }
      
      public function processor(param1:MessageEvent) : void
      {
      }
      
      public function get arenaUIController() : IArenaUIController
      {
         return this._secne.arenaUIController;
      }
      
      public function get fightController() : IFightController
      {
         return this._secne.fightController;
      }
      
      public function dispose() : void
      {
         this._secne = null;
      }
   }
}
