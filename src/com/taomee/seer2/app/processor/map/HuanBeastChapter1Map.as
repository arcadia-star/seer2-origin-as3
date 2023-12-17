package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class HuanBeastChapter1Map extends MapProcessor
   {
       
      
      private var fightNumId:int = 202179;
      
      protected var step:int;
      
      protected var monsterId:int;
      
      protected var fightId:int;
      
      public function HuanBeastChapter1Map(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         ActorManager.showRemoteActor = false;
         ActiveCountManager.requestActiveCount(this.fightNumId,this.getFightStep);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
      
      private function getFightStep(param1:int, param2:int) : void
      {
         if(param1 == this.fightNumId)
         {
            if(param2 == this.step)
            {
               this.createMonster();
            }
            else if(param2 > 6 && !QuestManager.isStepComplete(10175,3))
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
               QuestManager.completeStep(10175,3);
            }
            else
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("HuanBeastPanel"),"打开中...","1");
            }
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         if(event.questId == 10175 && event.stepId == 3)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            AlertManager.showAlert("你现在已经证明了自己的实力，你可以去找玛妈了",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,230);
            });
         }
      }
      
      private function createMonster() : void
      {
         var _loc2_:SpawnedPet = null;
         this.fightId = this.step + 305;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = new SpawnedPet(this.monsterId,this.fightId,0);
            MobileManager.addMobile(_loc2_,MobileType.SPAWNED_PET);
            _loc1_++;
         }
      }
   }
}
