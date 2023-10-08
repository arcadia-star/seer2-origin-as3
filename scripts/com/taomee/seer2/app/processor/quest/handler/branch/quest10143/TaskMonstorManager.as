package com.taomee.seer2.app.processor.quest.handler.branch.quest10143
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.Sprite;
   import org.taomee.utils.DisplayUtil;
   
   public class TaskMonstorManager
   {
      
      private static var _self:com.taomee.seer2.app.processor.quest.handler.branch.quest10143.TaskMonstorManager;
       
      
      private const RES_ID:int = 129;
      
      private const MONSTOR_NUM:int = 5;
      
      private var _activityMonsterVec:Vector.<SpawnedPet>;
      
      private var _num:int;
      
      private var _actNum:int;
      
      private var _callBack:Function;
      
      private var _mouseHint:Sprite;
      
      public function TaskMonstorManager()
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.processor.quest.handler.branch.quest10143.TaskMonstorManager
      {
         if(_self == null)
         {
            _self = new com.taomee.seer2.app.processor.quest.handler.branch.quest10143.TaskMonstorManager();
         }
         return _self;
      }
      
      public function startShow(param1:Function, param2:int) : void
      {
         var _loc4_:SpawnedPet = null;
         this._mouseHint = new MouseClickHintSprite();
         this._callBack = param1;
         this._actNum = param2;
         this._activityMonsterVec = Vector.<SpawnedPet>([]);
         var _loc3_:uint = 0;
         while(_loc3_ < this.MONSTOR_NUM)
         {
            _loc4_ = new SpawnedPet(this.RES_ID,235,0);
            this._activityMonsterVec.push(_loc4_);
            MobileManager.addMobile(_loc4_,MobileType.SPAWNED_PET);
            ++this._num;
            if(_loc3_ == 0)
            {
               this.showMouseHintAtMonster(_loc4_);
            }
            _loc3_++;
         }
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active.mapID != 10108 && SceneManager.active.type != SceneType.ARENA)
         {
            this.dispose();
            return;
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == 235)
         {
            --this._num;
            --this._actNum;
            this._activityMonsterVec = Vector.<SpawnedPet>([]);
            if(this._actNum == 0)
            {
               this._callBack.call();
            }
         }
         this.updateMonstor();
      }
      
      private function updateMonstor() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:SpawnedPet = null;
         if(this._actNum == 0)
         {
            return;
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && SceneManager.prevMapID == 100010)
         {
            _loc1_ = 0;
            while(_loc1_ < this._num)
            {
               _loc2_ = new SpawnedPet(this.RES_ID,235,0);
               this._activityMonsterVec.push(_loc2_);
               MobileManager.addMobile(_loc2_,MobileType.SPAWNED_PET);
               if(_loc1_ == 0)
               {
                  this.showMouseHintAtMonster(_loc2_);
               }
               _loc1_++;
            }
         }
      }
      
      public function showMouseHintAtMonster(param1:SpawnedPet) : void
      {
         if(Boolean(this._mouseHint) && Boolean(this._mouseHint.parent))
         {
            DisplayUtil.removeForParent(this._mouseHint);
            this._mouseHint = null;
         }
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -this._mouseHint.height + 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 - 10;
         param1.addChild(this._mouseHint);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(this._activityMonsterVec)
         {
            _loc1_ = 0;
            while(_loc1_ < this._activityMonsterVec.length)
            {
               if(this._activityMonsterVec[_loc1_])
               {
                  MobileManager.removeMobile(this._activityMonsterVec[_loc1_],MobileType.SPAWNED_PET);
               }
               _loc1_++;
            }
         }
         this._activityMonsterVec = null;
         _self = null;
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
      }
   }
}
