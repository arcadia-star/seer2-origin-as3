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
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   
   public class MapProcessor_6102 extends MapProcessor
   {
       
      
      public function MapProcessor_6102(param1:MapModel)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ActorManager.showRemoteActor = true;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      override public function init() : void
      {
         ActorManager.showRemoteActor = false;
         ActiveCountManager.requestActiveCount(202133,this.setCount);
         DisplayObjectUtil.removeFromParent(_map.content["kaniyaya"]);
      }
      
      private function setCount(param1:int, param2:int) : void
      {
         var type:int = param1;
         var times:int = param2;
         if(type == 202133 && times == 6)
         {
            this.getFightNum();
         }
         else if(QuestManager.isStepComplete(10164,3) && !QuestManager.isStepComplete(10164,4))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            QuestManager.completeStep(10164,4);
         }
         else
         {
            AlertManager.showAlert("你现在收集到了氏族的能源精华，\n你可以去找卡特琳娜了",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,840);
            });
         }
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         if(event.questId == 10164 && event.stepId == 4)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            AlertManager.showAlert("你现在收集到了氏族的能源精华，\n你可以去找卡特琳娜了",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,840);
            });
         }
      }
      
      private function getFightNum() : void
      {
         var _loc2_:SpawnedPet = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = new SpawnedPet(127,270,0);
            MobileManager.addMobile(_loc2_,MobileType.SPAWNED_PET);
            _loc1_++;
         }
      }
   }
}
