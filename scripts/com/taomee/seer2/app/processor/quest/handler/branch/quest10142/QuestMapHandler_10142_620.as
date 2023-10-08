package com.taomee.seer2.app.processor.quest.handler.branch.quest10142
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   
   public class QuestMapHandler_10142_620 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10142_620(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 4;
         _y = 150;
         _x = 598;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(700,150);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
