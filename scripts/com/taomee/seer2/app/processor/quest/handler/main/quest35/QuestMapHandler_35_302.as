package com.taomee.seer2.app.processor.quest.handler.main.quest35
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   
   public class QuestMapHandler_35_302 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_35_302(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "35_3")
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            QuestManager.completeStep(_quest.id,3);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            _processor.showMouseHintAt(-23,95);
         }
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
      }
   }
}
