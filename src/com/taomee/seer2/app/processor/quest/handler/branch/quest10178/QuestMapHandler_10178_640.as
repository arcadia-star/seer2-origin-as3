package com.taomee.seer2.app.processor.quest.handler.branch.quest10178
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10178_640 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10178_640(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedToAccept())
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
         if(isNeedCompleteStep(1))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
         if(isNeedCompleteStep(2))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
         if(!QuestManager.isComplete(questID))
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10178)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10178_2"),null,true,true);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10178)
         {
            if(param1.stepId == 1)
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10178_1"),null,false,false,1,false);
            }
            else if(param1.stepId == 2)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("QinBeastPanel"),"","1");
            }
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == 10178)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10178_0"),null,true,true);
         }
      }
   }
}
