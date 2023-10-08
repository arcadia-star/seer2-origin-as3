package com.taomee.seer2.app.processor.quest.handler.branch.quest10205
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.branch.quest10194.CandlePelayHandler;
   
   public class QuestMapHandler_10205_124 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10205_124(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 4;
         _y = 467;
         _x = 684;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(664,289);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
