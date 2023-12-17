package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   
   public class QuestProcessor_10044 extends QuestProcessor
   {
       
      
      public function QuestProcessor_10044(param1:Quest)
      {
         super(param1);
         if(QuestManager.isAccepted(10044))
         {
            this.updateQuestStatus();
         }
         else
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onQuestAccepted);
         }
      }
      
      private function onQuestAccepted(param1:QuestEvent) : void
      {
         if(param1.questId == 10044)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccepted);
            this.updateQuestStatus();
         }
      }
      
      private function updateQuestStatus() : void
      {
         var _loc1_:uint = uint(_quest.getStepData(1,0));
         if(QuestManager.isStepComplete(10044,1) == false && _loc1_ >= 5)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            QuestManager.completeStep(_quest.id,1);
         }
         else if(QuestManager.isStepComplete(10044,1) == false)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
         }
      }
      
      private function onMapComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active.mapID == 510 && Boolean(_quest.isStepCompletable(1)))
         {
            this.processStep1();
         }
      }
      
      private function processStep1() : void
      {
         var _loc1_:uint = 0;
         if(_quest.getStepData(1,0) >= 5)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            QuestManager.completeStep(_quest.id,1);
         }
         else if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex < 10 && FightManager.fightWinnerSide == FightSide.LEFT)
            {
               _loc1_ = uint(_quest.getStepData(1,0));
               _quest.setStepData(1,0,_loc1_ + 1);
               QuestManager.setStepBufferServer(_quest.id,1);
            }
            if(_quest.getStepData(1,0) >= 5)
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
               QuestManager.completeStep(_quest.id,1);
            }
            else
            {
               ServerMessager.addMessage("还需要找回 <font color=\'#ffcc00\'>" + (5 - _quest.getStepData(1,0)) + " </font> 把 <font color=\'#ffcc00\'>刷子</font>");
            }
         }
      }
      
      private function onCompleteStep1(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            if(SceneManager.active && SceneManager.active.type == SceneType.LOBBY && SceneManager.prevSceneType == SceneType.ARENA)
            {
               ServerMessager.addMessage("所有刷子都找回啦，快回 <font color=\'#ffcc00\'>小屋</font> 看看装修进度吧");
            }
         }
      }
      
      override public function dispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccepted);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
         super.dispose();
      }
   }
}
