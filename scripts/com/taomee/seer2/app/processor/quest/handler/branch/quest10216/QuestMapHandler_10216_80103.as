package com.taomee.seer2.app.processor.quest.handler.branch.quest10216
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10216_80103 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10216_80103(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedCompleteStep(1))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         if(event.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            if(event.stepId == 1)
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10216_1"),function():void
               {
                  SceneManager.changeScene(SceneType.COPY,80106);
               },true,true);
            }
         }
      }
   }
}
