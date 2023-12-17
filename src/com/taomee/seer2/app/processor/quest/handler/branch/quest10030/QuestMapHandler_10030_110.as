package com.taomee.seer2.app.processor.quest.handler.branch.quest10030
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   
   public class QuestMapHandler_10030_110 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10030_110(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1))
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var _loc2_:String = param1.params;
         if(_loc2_ == "10030_1")
         {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            QuestManager.completeStep(_quest.id,2);
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
      }
   }
}
