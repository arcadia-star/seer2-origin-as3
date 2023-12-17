package com.taomee.seer2.app.processor.quest.handler.main.quest98
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.geom.Point;
   
   public class QuestMapHandler_98_3848 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_98_3848(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReply);
         }
      }
      
      private function onCustomReply(param1:DialogPanelEvent) : void
      {
         if(DialogPanelEventData(param1.content).params == "98_2")
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.initStep3);
            QuestManager.completeStep(questID,2);
         }
         else if(DialogPanelEventData(param1.content).params == "98_1")
         {
            SceneManager.changeScene(SceneType.LOBBY,3848);
         }
      }
      
      private function initStep3(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.initStep3);
         SeatTipsManager.registerSeat(new Point(920,180),3848);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         RightToolbarConter.instance.show();
      }
   }
}
