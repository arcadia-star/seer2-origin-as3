package com.taomee.seer2.app.processor.quest.handler.branch.quest10248
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   
   public class QuestMapHandler_10248_320 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10248_320(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 4;
         _y = 104;
         _x = 418;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(542,260);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
