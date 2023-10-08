package com.taomee.seer2.app.processor.activity.processorQuest
{
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   
   public class Quest53Processor
   {
       
      
      public function Quest53Processor()
      {
         super();
      }
      
      public static function checkQuest() : void
      {
         if(QuestManager.isComplete(53) == false && QuestManager.isCanAccepted(53))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
            QuestManager.accept(53);
         }
         else if(QuestManager.isComplete(53) == false && QuestManager.isStepComplete(53,1) == false)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(53,1);
         }
         else if(QuestManager.isComplete(53) == false && QuestManager.isStepComplete(53,2) == false)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(53,2);
         }
         else if(QuestManager.isComplete(53) == false && QuestManager.isStepComplete(53,3) == false)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(53,3);
         }
         else if(QuestManager.isComplete(53) == false && QuestManager.isStepComplete(53,4) == false)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(53,4);
         }
         else if(QuestManager.isComplete(53) == false && QuestManager.isStepComplete(53,5) == false)
         {
            QuestManager.completeStep(53,5);
         }
      }
      
      private static function onStepComplete(param1:QuestEvent) : void
      {
         checkQuest();
      }
      
      private static function onAccept(param1:QuestEvent) : void
      {
         checkQuest();
      }
   }
}
