package com.taomee.seer2.app.processor.quest.handler.main.quest5
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   
   public class QuestMapHandler_5_90 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_5_90(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.isStepCompete(2))
         {
            if(!_quest.isStepCompete(3))
            {
               this.processStep3();
            }
            else if(!_quest.isStepCompete(4))
            {
               _processor.showMouseHintAt(500,110);
            }
            else if(!_quest.isStepCompete(5))
            {
               _processor.showMouseHintAt(30,300);
            }
         }
      }
      
      private function processStep3() : void
      {
         DialogPanel.showForSimple(400,"我",[[0,"特鲁伊是在 <font color=\'#ffcc00\'>深幽沼泽</font> 被抓的！我去那里看看！"]],"前往深幽沼泽……",function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete3);
            QuestManager.completeStep(_quest.id,3);
         });
      }
      
      private function onStepComplete3(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete3);
            _processor.showMouseHintAt(500,110);
         }
      }
      
      override public function processMapDispose() : void
      {
      }
   }
}
