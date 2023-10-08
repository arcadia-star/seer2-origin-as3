package com.taomee.seer2.app.arena.resource
{
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.data.ArenaDataInfo;
   import com.taomee.seer2.app.arena.data.FighterInfo;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.decoration.DecorationControl;
   import com.taomee.seer2.app.arena.effect.FighterSound;
   import com.taomee.seer2.app.arena.effect.SkillEffect;
   import com.taomee.seer2.app.arena.effect.SkillSound;
   import com.taomee.seer2.app.arena.resource.events.ResourceQueueEvent;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import com.taomee.seer2.core.cache.CacheType;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class ArenaResourceLoader
   {
      
      private static var _instance:com.taomee.seer2.app.arena.resource.ArenaResourceLoader;
       
      
      private var _onComplete:Function;
      
      private var _resourceQueue:com.taomee.seer2.app.arena.resource.ResourceQueue;
      
      private var _arenaLoadingBar:com.taomee.seer2.app.arena.resource.ArenaLoadingBar;
      
      public function ArenaResourceLoader()
      {
         super();
      }
      
      public static function get instance() : com.taomee.seer2.app.arena.resource.ArenaResourceLoader
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.arena.resource.ArenaResourceLoader();
         }
         return _instance;
      }
      
      public static function addLoadingBar() : void
      {
         instance.addArenaLoadingBar();
      }
      
      public static function hideLoadingBar() : void
      {
         instance.removeLoadingBar();
      }
      
      private function addArenaLoadingBar() : void
      {
         this._arenaLoadingBar = new com.taomee.seer2.app.arena.resource.ArenaLoadingBar();
         LayerManager.stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize(null);
         this._arenaLoadingBar.addEventListener(Event.CLOSE,this.onArenaLoadingBarClose);
         LayerManager.topLayer.addChild(this._arenaLoadingBar);
      }
      
      private function onResize(param1:Event) : void
      {
         this._arenaLoadingBar.scaleX = LayerManager.stage.stageWidth / 1200;
         this._arenaLoadingBar.scaleY = LayerManager.stage.stageHeight / 660;
      }
      
      private function removeLoadingBar() : void
      {
         DisplayUtil.removeForParent(this._arenaLoadingBar);
      }
      
      private function onArenaLoadingBarClose(param1:Event) : void
      {
         LayerManager.stage.removeEventListener(Event.RESIZE,this.onResize);
         this._arenaLoadingBar.removeEventListener(Event.CLOSE,this.onArenaLoadingBarClose);
         this._arenaLoadingBar.dispose();
         DisplayObjectUtil.removeFromParent(this._arenaLoadingBar);
         SoundManager.backgroundSoundEnabled = true;
         this._onComplete();
         this.clear();
      }
      
      public function updateLoadingBarShowData(param1:Function, param2:FighterInfo, param3:FighterInfo, param4:FighterInfo, param5:FighterInfo, param6:ArenaDataInfo = null) : void
      {
         this._onComplete = param1;
         this._arenaLoadingBar.setLeftFighterInfo(param2,param4);
         this._arenaLoadingBar.setRightFighterInfo(param3,param5);
         this._arenaLoadingBar.setFightPress(param2,param4,param3,param5);
         if(param6)
         {
            if(param6.fightMode == FightMode.SINGLE_PVE)
            {
               if(param3.typeId != 1)
               {
                  this._arenaLoadingBar.addFightInfoRelation(param3.typeId);
               }
            }
         }
      }
      
      public function loadFightResource(param1:FighterTeam, param2:FighterTeam, param3:ArenaDataInfo) : void
      {
         this._resourceQueue = new com.taomee.seer2.app.arena.resource.ResourceQueue();
         param1.createFighter(this._resourceQueue,param3);
         param2.createFighter(this._resourceQueue,param3);
         if(DecorationControl._isShowDecoration)
         {
            DecorationControl.startLoad(this._resourceQueue);
         }
         this.addSkillEffectToQueue(param1);
         this.addSkillEffectToQueue(param2);
         this.addSkillSoundToQueue(param1);
         this.addSkillSoundToQueue(param2);
         this.addFighterSoundToQueue(param1);
         this._resourceQueue.addEventListener(ProgressEvent.PROGRESS,this.onQueueProgress);
         this._resourceQueue.addEventListener(ResourceQueueEvent.QUEUE_COMPLETE,this.onQueueLoaded);
         this._resourceQueue.startLoad();
      }
      
      private function onQueueLoaded(param1:ResourceQueueEvent) : void
      {
         this._resourceQueue.removeEventListener(ProgressEvent.PROGRESS,this.onQueueProgress);
         this._resourceQueue.removeEventListener(ResourceQueueEvent.QUEUE_COMPLETE,this.onQueueLoaded);
         this.updateArenaLoadingBar(100);
      }
      
      private function addSkillEffectToQueue(param1:FighterTeam) : void
      {
         var _loc2_:Fighter = null;
         var _loc3_:SkillInfo = null;
         var _loc4_:SkillEffect = null;
         for each(_loc2_ in param1.fighterVec)
         {
            for each(_loc3_ in _loc2_.fighterInfo.skillInfoVec)
            {
               _loc4_ = new SkillEffect(_loc2_.fighterInfo.bunchId,_loc3_);
               _loc2_.addSkillEffect(_loc4_);
               this._resourceQueue.addCache(CacheType.EFFECT,_loc4_.getResourceUrl(),_loc4_.onResourceLoaded);
            }
         }
      }
      
      private function addSkillSoundToQueue(param1:FighterTeam) : void
      {
         var _loc2_:Fighter = null;
         var _loc3_:Fighter = null;
         var _loc4_:SkillInfo = null;
         var _loc5_:SkillSound = null;
         var _loc6_:SkillInfo = null;
         var _loc7_:SkillSound = null;
         if(SoundManager.isAvailable == false)
         {
            return;
         }
         for each(_loc2_ in param1.fighterVec)
         {
            for each(_loc4_ in _loc2_.fighterInfo.skillInfoVec)
            {
               _loc5_ = new SkillSound(_loc2_.fighterInfo.bunchId,_loc4_);
               _loc2_.addSkillSound(_loc5_);
               this._resourceQueue.addItem(LoadType.SOUND,_loc5_.getSoundUrl(),_loc5_.onSoundLoaded);
            }
         }
         for each(_loc3_ in param1.changeFighterVec)
         {
            for each(_loc6_ in _loc3_.fighterInfo.skillInfoVec)
            {
               if(_loc6_.id != 0)
               {
                  _loc7_ = new SkillSound(_loc3_.fighterInfo.bunchId,_loc6_);
                  _loc3_.addSkillSound(_loc7_);
                  this._resourceQueue.addItem(LoadType.SOUND,_loc7_.getSoundUrl(),_loc7_.onSoundLoaded);
               }
            }
         }
      }
      
      private function addFighterSoundToQueue(param1:FighterTeam) : void
      {
         var _loc2_:Fighter = null;
         var _loc3_:FighterSound = null;
         if(SoundManager.isAvailable == false)
         {
            return;
         }
         for each(_loc2_ in param1.fighterVec)
         {
            _loc3_ = new FighterSound(_loc2_.fighterInfo.resourceId);
            _loc2_.setFighterSound(_loc3_);
            this._resourceQueue.addItem(LoadType.SOUND,_loc3_.getSoundUrl(),_loc3_.onSoundLoaded);
         }
      }
      
      private function onQueueProgress(param1:ProgressEvent) : void
      {
         this.updateArenaLoadingBar(this._resourceQueue.getLoadedPercent());
      }
      
      private function updateArenaLoadingBar(param1:int) : void
      {
         this._arenaLoadingBar.updateProgress(param1);
      }
      
      private function clear() : void
      {
         this._resourceQueue = null;
         this._arenaLoadingBar = null;
      }
   }
}
