package com.taomee.seer2.app.processor.quest.handler.main.quest3
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   
   public class QuestMapHandler_3_90 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_3_90(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.isStepCompletable(2))
         {
            _processor.showMouseHintAt(590,520);
         }
         else if(Boolean(_quest.isStepCompete(6)) && !_quest.isStepCompete(7))
         {
            _processor.showMouseHintAt(-70,405);
         }
      }
   }
}
