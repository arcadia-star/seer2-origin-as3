package com.taomee.seer2.app.processor.quest.handler.story.quest32
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   
   public class QuestMapHandler_32_660 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_32_660(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         QuestManager.completeStep(_quest.id,2);
      }
   }
}
