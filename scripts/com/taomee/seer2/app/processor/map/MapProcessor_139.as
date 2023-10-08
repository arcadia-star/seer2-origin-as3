package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dream.DreamSpawnedPet;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   
   public class MapProcessor_139 extends DreamMapProcessor
   {
       
      
      private const GU_SI_RES_ID:uint = 22;
      
      private const FIGHT_MAP_TYPE:uint = 10001;
      
      private const DREAM_NPC_TYPE:uint = 401;
      
      private var _fightData:Object;
      
      private var _dreamSpawnedPet:DreamSpawnedPet;
      
      public function MapProcessor_139(param1:MapModel)
      {
         _taskId = 1;
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.initFightData();
         this.setDreamAction();
         this.initGuSi();
      }
      
      private function initFightData() : void
      {
         this._fightData = new Object();
         this._fightData.dreamNpcType = this.DREAM_NPC_TYPE;
         this._fightData.fightMapType = this.FIGHT_MAP_TYPE;
         this._fightData.taskId = _taskId;
      }
      
      private function setDreamAction() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            _dreamer.gotoAndPlay("monsterKilled");
            indicateLeaveDream();
         }
      }
      
      override protected function onDreamerMouseOver(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(_dreamer.currentFrameLabel == "enterMapEnd")
         {
            _dreamer.gotoAndPlay("enterMap");
         }
         else if(_dreamer.currentFrameLabel == "monsterKilledEnd")
         {
            _dreamer.gotoAndPlay("monsterKilled");
         }
      }
      
      private function initGuSi() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(SceneManager.prevSceneType != SceneType.ARENA)
         {
            MobileManager.clearMobileVec(MobileType.SPAWNED_PET);
            _loc1_ = Math.floor(Math.random() * 8) + 1;
            _loc2_ = Math.floor(Math.random() * 2) + 6;
            this._dreamSpawnedPet = new DreamSpawnedPet(this.GU_SI_RES_ID,_loc1_,_loc2_,this._fightData);
            MobileManager.addMobile(this._dreamSpawnedPet,MobileType.DREAM_SPAWNED_PET);
         }
      }
      
      override public function dispose() : void
      {
         this._dreamSpawnedPet = null;
         this._fightData = null;
         super.dispose();
      }
   }
}
