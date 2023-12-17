package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class YiBeastChapter2MapProcessor extends MapProcessor
   {
       
      
      private var currentIndex:int = -1;
      
      private const MAP_LIST:Array = [2912,3013,2812];
      
      private const FIGHT_ID_LIST:Array = [518,519,520];
      
      private const LIMIT_ID_LIST:Array = [202991,202992,202993];
      
      private const MONSTER_ID_LIST:Array = [33,36,40];
      
      private const NAME_LIST:Array = ["红色火焰","黄色火焰","橙色火焰"];
      
      public function YiBeastChapter2MapProcessor(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.currentIndex = this.MAP_LIST.indexOf(_map.id);
         ActiveCountManager.requestActiveCount(this.LIMIT_ID_LIST[this.currentIndex],this.getCount);
      }
      
      private function getCount(param1:uint, param2:uint) : void
      {
         var type:uint = param1;
         var count:uint = param2;
         if(type == this.LIMIT_ID_LIST[this.currentIndex])
         {
            if(count == 20)
            {
               if(this.currentIndex != 2)
               {
                  AlertManager.showAlert("你已经取得了该层的所有火焰,去其他层看看吧",function():void
                  {
                     ModuleManager.toggleModule(URLUtil.getAppModule("YiBeastPanel"),"","2");
                  });
                  return;
               }
               if(QuestManager.isStepComplete(10199,3) == false)
               {
                  QuestManager.completeStep(10199,3);
               }
               AlertManager.showAlert("真厉害，你已经收集齐全部的火焰咯！",function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,302);
               });
            }
            else if(count < 20)
            {
               if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == this.FIGHT_ID_LIST[this.currentIndex])
               {
                  if(FightManager.fightWinnerSide == FightSide.LEFT)
                  {
                     ServerMessager.addMessage("你已经获得 " + count + "/20 " + this.NAME_LIST[this.currentIndex]);
                  }
               }
               this.createMonster();
            }
         }
      }
      
      private function createMonster() : void
      {
         var _loc1_:SpawnedPet = null;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new SpawnedPet(this.MONSTER_ID_LIST[this.currentIndex],this.FIGHT_ID_LIST[this.currentIndex],0);
            MobileManager.addMobile(_loc1_,MobileType.SPAWNED_PET);
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<Mobile> = MobileManager.getMobileVec(MobileType.SPAWNED_PET);
         if(_loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc1_[_loc2_].dispose();
               _loc2_++;
            }
         }
         super.dispose();
      }
   }
}
