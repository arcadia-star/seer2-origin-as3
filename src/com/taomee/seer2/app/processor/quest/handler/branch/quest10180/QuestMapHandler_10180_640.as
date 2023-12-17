package com.taomee.seer2.app.processor.quest.handler.branch.quest10180
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10180_640 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10180_640(param1:QuestProcessor)
      {
         super(param1);
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
         if(!QuestManager.isComplete(questID))
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10180)
         {
            if(param1.stepId == 1)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("QinBeastPanel"),"","2");
            }
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10180)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10180_1"),null,true,true);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == 10180)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10180_0"),null,true,true);
         }
      }
   }
}
