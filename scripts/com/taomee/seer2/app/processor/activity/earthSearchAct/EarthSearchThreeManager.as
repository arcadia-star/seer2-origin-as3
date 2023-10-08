package com.taomee.seer2.app.processor.activity.earthSearchAct
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   
   public class EarthSearchThreeManager
   {
      
      private static var _self:com.taomee.seer2.app.processor.activity.earthSearchAct.EarthSearchThreeManager;
       
      
      private var _obj:com.taomee.seer2.app.processor.activity.earthSearchAct.EarthSearchThreeLayer;
      
      private var _state:int;
      
      public function EarthSearchThreeManager()
      {
         super();
         this._state = 0;
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
      }
      
      public static function inistance() : com.taomee.seer2.app.processor.activity.earthSearchAct.EarthSearchThreeManager
      {
         if(null == _self)
         {
            _self = new com.taomee.seer2.app.processor.activity.earthSearchAct.EarthSearchThreeManager();
         }
         return _self;
      }
      
      public function set state(param1:int) : void
      {
         this._state = param1;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function addObj(param1:com.taomee.seer2.app.processor.activity.earthSearchAct.EarthSearchThreeLayer) : void
      {
         this._obj = param1;
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this._state = 2;
               this._obj.addBoss();
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
            }
         }
         if(SceneManager.prevMapID == 80372 && SceneManager.active.type != SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
            _self = null;
            this._obj = null;
         }
      }
   }
}
