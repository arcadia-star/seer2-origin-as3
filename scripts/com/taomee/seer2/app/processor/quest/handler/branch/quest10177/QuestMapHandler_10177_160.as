package com.taomee.seer2.app.processor.quest.handler.branch.quest10177
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   
   public class QuestMapHandler_10177_160 extends BasicQuest10177
   {
       
      
      public function QuestMapHandler_10177_160(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         needItemId = 603033;
         npcId = 23;
         fightIndex = 333;
         super.processMapComplete();
      }
   }
}
