package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.gameRule.spt.SPTBossID;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestProcessor_10048 extends QuestProcessor
   {
      
      private static const MAP_ID:Array = [152,193,270];
       
      
      public function QuestProcessor_10048(param1:Quest)
      {
         super(param1);
         if(QuestManager.isAccepted(10048))
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
         if(param1.questId == 10048)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccepted);
            this.updateQuestStatus();
         }
      }
      
      private function updateQuestStatus() : void
      {
         if(QuestManager.isStepComplete(10048,1) == false && _quest.getStepData(1,0) >= 1 && _quest.getStepData(1,1) >= 1 && _quest.getStepData(1,2) >= 1)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            QuestManager.completeStep(_quest.id,1);
         }
         else if(QuestManager.isStepComplete(10048,1) == false)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
         }
      }
      
      private function onMapComplete(param1:SceneEvent) : void
      {
         if(MAP_ID.indexOf(SceneManager.active.mapID) != -1 && Boolean(_quest.isStepCompletable(1)))
         {
            this.processStep1();
         }
      }
      
      private function processStep1() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(_quest.getStepData(1,0) >= 1 && _quest.getStepData(1,1) >= 1 && _quest.getStepData(1,2) >= 1)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            QuestManager.completeStep(_quest.id,1);
         }
         else if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            _loc1_ = MAP_ID.indexOf(SceneManager.active.mapResourceID);
            if(FightManager.fightWinnerSide == FightSide.LEFT && (SceneManager.active.mapResourceID == 152 && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.bossId && FightManager.currentFightRecord.initData.bossId == SPTBossID.MMdi || SceneManager.active.mapResourceID == 193 && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.bossId && FightManager.currentFightRecord.initData.bossId == SPTBossID.AKanasi || SceneManager.active.mapResourceID == 270 && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.bossId && FightManager.currentFightRecord.initData.bossId == SPTBossID.HuoKe))
            {
               _loc2_ = uint(_quest.getStepData(1,_loc1_));
               if(_loc2_ == 0)
               {
                  _quest.setStepData(1,_loc1_,1);
                  QuestManager.setStepBufferServer(_quest.id,1);
                  if(_quest.getStepData(1,0) >= 1 && _quest.getStepData(1,1) >= 1 && _quest.getStepData(1,2) >= 1)
                  {
                     SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
                     QuestManager.completeStep(_quest.id,1);
                  }
                  else
                  {
                     ModuleManager.showModule(URLUtil.getAppModule("DecorateQuestPanel"),"正在打开装修图纸……");
                  }
               }
            }
         }
      }
      
      private function onCompleteStep1(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            if(Boolean(SceneManager.active) && SceneManager.active.type == SceneType.LOBBY)
            {
               ServerMessager.addMessage("战胜三大系族BOSS啦，快回 <font color=\'#ffcc00\'>小屋</font> 看看装修进度吧");
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
