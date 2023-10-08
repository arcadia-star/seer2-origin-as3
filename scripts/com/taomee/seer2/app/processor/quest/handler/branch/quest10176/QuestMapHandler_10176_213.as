package com.taomee.seer2.app.processor.quest.handler.branch.quest10176
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10176_213 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10176_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedCompleteStep(1))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         }
         if(isNeedCompleteStep(3))
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10176)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10176_0"));
         }
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            if(param1.stepId == 1)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("HuanBeastPanel"),"","2");
            }
         }
      }
   }
}
