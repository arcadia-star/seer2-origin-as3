package com.taomee.seer2.app.processor.quest.handler.branch.quest10177
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   
   public class QuestMapHandler_10177_110 extends BasicQuest10177
   {
       
      
      public function QuestMapHandler_10177_110(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         needItemId = 603032;
         npcId = 16;
         fightIndex = 332;
         super.processMapComplete();
      }
   }
}
