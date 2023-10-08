package com.taomee.seer2.app.processor.quest.handler.branch.quest10175
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10175_192 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10175_192(param1:QuestProcessor)
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
         if(!isAccepted() && !QuestManager.isComplete(questID))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
         if(isNeedCompleteStep(1))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            if(param1.stepId == 1)
            {
               SceneManager.changeScene(SceneType.LOBBY,230);
            }
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10175_0"));
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
      }
   }
}
