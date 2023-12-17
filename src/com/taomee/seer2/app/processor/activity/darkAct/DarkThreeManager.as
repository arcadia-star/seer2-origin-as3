package com.taomee.seer2.app.processor.activity.darkAct
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   
   public class DarkThreeManager
   {
      
      private static var _self:DarkThreeManager;
       
      
      private var _obj:DarkThreeLayer;
      
      private var _state:int;
      
      public function DarkThreeManager()
      {
         super();
         this._state = 0;
         StatisticsManager.sendNovice(StatisticsManager.uui_interact_412);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
      }
      
      public static function inistance() : DarkThreeManager
      {
         if(null == _self)
         {
            _self = new DarkThreeManager();
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
      
      public function addObj(param1:DarkThreeLayer) : void
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
               ServerMessager.addMessage("已经通过本层关卡");
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
            }
         }
         if(SceneManager.prevMapID == 80013 && SceneManager.active.type != SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
            _self = null;
            this._obj = null;
         }
      }
   }
}
