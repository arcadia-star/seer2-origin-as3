package com.taomee.seer2.app.processor.quest.handler.activity.quest30040
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class DiscolorMap extends QuestMapHandler
   {
       
      
      private var currentCount:int = 0;
      
      protected var limitId:int;
      
      protected var stepId:int;
      
      protected var petId:int;
      
      protected var fightId:int;
      
      protected var backId:int;
      
      private var maxNum:int;
      
      private var teleport:Teleport;
      
      public function DiscolorMap(param1:QuestProcessor)
      {
         super(param1);
      }
      
      public function createSaturationFilter(param1:Number) : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.3086 * (1 - param1) + param1,0.6094 * (1 - param1),0.082 * (1 - param1),0,0,0.3086 * (1 - param1),0.6094 * (1 - param1) + param1,0.082 * (1 - param1),0,0,0.3086 * (1 - param1),0.6094 * (1 - param1),0.082 * (1 - param1) + param1,0,0,0,0,0,1,0]);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.getActNum);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         LayerManager.mapLayer.filters = [];
         (SceneManager.active as LobbyScene).showToolbar();
         this.teleport.removeEventListener(MouseEvent.CLICK,this.quitTips);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
         if(isNeedCompleteStep(this.stepId))
         {
            ActiveCountManager.requestActiveCount(this.limitId,this.getActNum);
         }
         this.teleport = AnimateElementManager.getElement(1) as Teleport;
         this.teleport.addEventListener(MouseEvent.CLICK,this.quitTips,false,100);
      }
      
      protected function quitTips(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this.currentCount < 10)
         {
            AlertManager.showConfirm("离开后将暂停试炼，可通过约瑟日志再次进入。",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,backId);
            });
         }
         event.stopImmediatePropagation();
      }
      
      private function getActNum(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         this.currentCount = param2;
         if(this.currentCount >= 10)
         {
            if(this.stepId == 7)
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
            }
            else
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
            }
            QuestManager.completeStep(questID,this.stepId);
            return;
         }
         this.maxNum = 0;
         if(this.currentCount < 2)
         {
            this.maxNum = 2;
            _loc3_ = 0;
         }
         else if(this.currentCount < 4)
         {
            this.maxNum = 4;
            _loc3_ = 0.5;
         }
         else if(this.currentCount < 7)
         {
            this.maxNum = 7;
            _loc3_ = 0.75;
         }
         else if(this.currentCount < 10)
         {
            this.maxNum = 10;
            _loc3_ = 1;
         }
         LayerManager.mapLayer.filters = [this.createSaturationFilter(_loc3_)];
         this.createPet();
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 30040)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            SceneManager.changeScene(SceneType.LOBBY,this.backId);
         }
      }
      
      private function onCompleteStep(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         if(event.questId == questID && event.stepId == this.stepId)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
            AlertManager.showAlert("你已经治愈了前面的精灵，等待下一个精灵的解锁。",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,backId);
            });
         }
      }
      
      private function createPet() : void
      {
         var _loc3_:SpawnedPet = null;
         var _loc1_:int = this.maxNum - this.currentCount;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new SpawnedPet(this.petId,this.fightId,0);
            MobileManager.addMobile(_loc3_,MobileType.SPAWNED_PET);
            _loc2_++;
         }
      }
   }
}
