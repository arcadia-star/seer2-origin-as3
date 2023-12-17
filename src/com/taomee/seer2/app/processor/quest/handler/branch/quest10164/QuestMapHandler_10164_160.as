package com.taomee.seer2.app.processor.quest.handler.branch.quest10164
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10164_160 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10164_160(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onReply);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedCompleteStep(1))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onReply);
         }
         if(isNeedCompleteStep(2))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
         if(isNeedCompleteStep(6))
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10164)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10164_0"));
         }
      }
      
      private function onReply(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "playNpcTalk")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onReply);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10164_0"),4,[[1,0]],function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
               QuestManager.completeStep(questID,1);
            });
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(questID == param1.questId)
         {
            if(param1.stepId == 2)
            {
               SceneManager.changeScene(SceneType.LOBBY,840);
            }
         }
      }
   }
}
