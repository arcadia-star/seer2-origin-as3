package com.taomee.seer2.app.processor.quest.handler.branch.quest10207
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.branch.quest10194.CandlePelayHandler;
   
   public class QuestMapHandler_10207_133 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10207_133(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 1;
         _y = 404;
         _x = 268;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(249,219);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
