package com.taomee.seer2.app.processor.quest.handler.activity.quest30011
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_30011_50 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30011_50(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId && param1.stepId == 2)
         {
            SceneManager.changeScene(SceneType.LOBBY,90);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         super.processMapDispose();
      }
   }
}
