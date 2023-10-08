package com.taomee.seer2.app.processor.quest.handler.branch.quest10194
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   
   public class QuestMapHandler_10194_220 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10194_220(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 8;
         _y = 479;
         _x = 467;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(448,298);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
