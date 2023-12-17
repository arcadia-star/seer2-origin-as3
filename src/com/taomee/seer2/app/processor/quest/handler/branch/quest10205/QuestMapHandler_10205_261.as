package com.taomee.seer2.app.processor.quest.handler.branch.quest10205
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.branch.quest10194.CandlePelayHandler;
   
   public class QuestMapHandler_10205_261 extends CandlePelayHandler
   {
       
      
      public function QuestMapHandler_10205_261(param1:QuestProcessor)
      {
         super(param1);
         _questIndex = 11;
         _x = 326;
         _y = 403;
      }
      
      override protected function showGuide() : void
      {
         _processor.showMouseHintAt(307,224);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
      }
   }
}
