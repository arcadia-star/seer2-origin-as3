package com.taomee.seer2.app.processor.quest.handler.branch.quest10170
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10170_160 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10170_160(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!isAccepted() && !QuestManager.isComplete(questID))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
         if(isNeedCompleteStep(2))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
         if(isNeedCompleteStep(3))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
         if(isNeedCompleteStep(5))
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10170)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10170_1"));
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            if(param1.stepId == 2)
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10170_0"));
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            }
            else if(param1.stepId == 3)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("BagginsLogPanel"));
            }
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY,840);
         }
      }
   }
}
