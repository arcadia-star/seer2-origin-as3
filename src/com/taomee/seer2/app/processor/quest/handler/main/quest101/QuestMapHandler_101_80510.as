package com.taomee.seer2.app.processor.quest.handler.main.quest101
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.errors.IllegalOperationError;

   public class QuestMapHandler_101_80510 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_101_80510(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 42
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1 == null || param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            SceneManager.changeScene(SceneType.COPY,80509);
         }
      }
   }
}
