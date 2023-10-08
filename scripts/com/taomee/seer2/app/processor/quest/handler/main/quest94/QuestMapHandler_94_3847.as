package com.taomee.seer2.app.processor.quest.handler.main.quest94
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_94_3847 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_94_3847(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(94) && QuestManager.isComplete(questID) == false)
         {
            RightToolbarConter.instance.hide();
            if(QuestManager.isStepComplete(questID,4) && !QuestManager.isStepComplete(questID,5))
            {
               DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReply);
            }
         }
      }
      
      private function onCustomReply(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if(DialogPanelEventData(evt.content).params == "94_5")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReply);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("94_2"),function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               QuestManager.completeStep(questID,5);
            });
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().show();
         RightToolbarConter.instance.show();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         RightToolbarConter.instance.show();
      }
   }
}
