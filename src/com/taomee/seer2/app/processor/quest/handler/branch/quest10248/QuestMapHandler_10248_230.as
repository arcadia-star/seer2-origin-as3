package com.taomee.seer2.app.processor.quest.handler.branch.quest10248
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   
   public class QuestMapHandler_10248_230 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10248_230(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 3;
         _y = 204;
         _x = 308;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(440,350);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
