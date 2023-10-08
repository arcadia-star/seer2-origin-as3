package com.taomee.seer2.app.processor.quest.handler.branch.quest10121
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   
   public class QuestMapHandler_10121_201 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10121_201(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 6;
         _x = 254;
         _y = 363;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(235,183);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
