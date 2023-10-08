package com.taomee.seer2.app.processor.quest.handler.main.quest100
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   
   public class QuestMapHandler_100_80509 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_100_80509(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(100))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
         else if(QuestManager.isAccepted(100) && !QuestManager.isComplete(100) && QuestManager.isStepComplete(100,1) == false)
         {
            this.initStep1();
         }
      }
      
      protected function onAccept(param1:QuestEvent) : void
      {
         StatisticsManager.newSendNovice("2016活动","主线谜团渐进","谜团渐进任务接取");
         if(_quest.id == param1.questId)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 19
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1 == null || param1.questId == 100 && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         }
      }
   }
}
