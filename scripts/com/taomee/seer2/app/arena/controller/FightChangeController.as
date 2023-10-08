package com.taomee.seer2.app.arena.controller
{
   import com.taomee.seer2.app.arena.ArenaScene;
   
   public class FightChangeController
   {
       
      
      private var _scene:ArenaScene;
      
      private var _controller:com.taomee.seer2.app.arena.controller.IFighterChange;
      
      public function FightChangeController(param1:ArenaScene)
      {
         super();
         this._scene = param1;
      }
      
      public function dispose() : void
      {
         this._scene = null;
         if(this._controller != null)
         {
            this._controller.dispose();
         }
      }
      
      public function changeFighter(param1:uint, param2:uint, param3:uint, param4:uint = 1) : void
      {
         this.getController().changeFighter(param1,param2,param3,param4);
      }
      
      public function checkRightFighterChanged() : void
      {
         this.getController().checkRightFighterChanged();
      }
      
      private function getController() : com.taomee.seer2.app.arena.controller.IFighterChange
      {
         if(this._controller == null)
         {
            if(this._scene.arenaData.isDoubleMode)
            {
               this._controller = new DoubleModeChange(this._scene);
            }
            else
            {
               this._controller = new SingleModeChange(this._scene);
            }
         }
         return this._controller;
      }
   }
}
