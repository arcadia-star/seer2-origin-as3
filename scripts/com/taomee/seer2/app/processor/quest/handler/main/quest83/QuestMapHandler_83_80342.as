package com.taomee.seer2.app.processor.quest.handler.main.quest83
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_83_80342 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_83_80342(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,7) && !QuestManager.isStepComplete(questID,8))
         {
            this.quest7();
         }
      }
      
      private function quest7() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.NEW_QUEST_FIGHT_COUNT,this.onServer);
         }
      }
      
      private function onServer(param1:ServerBuffer) : void
      {
         var _loc2_:int = param1.readDataAtPostion(0) + 1;
         if(_loc2_ >= 3)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            QuestManager.completeStep(83,8);
         }
         else
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.NEW_QUEST_FIGHT_COUNT,0,_loc2_);
            ServerMessager.addMessage("已战胜" + _loc2_ + "/3");
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         var _loc2_:Object = new Object();
         _loc2_.index = 6;
         ModuleManager.showModule(URLUtil.getAppModule("GudieFightCompletePanel"),"",_loc2_);
         StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","完成成长试炼1");
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         super.processMapDispose();
      }
   }
}
