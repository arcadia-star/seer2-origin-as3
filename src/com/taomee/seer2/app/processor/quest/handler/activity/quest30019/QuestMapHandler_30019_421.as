package com.taomee.seer2.app.processor.quest.handler.activity.quest30019
{
   import com.taomee.seer2.app.gameRule.door.binary.BinaryDoorSupport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.activity.quest30015.DoorQuestMapHandler;
   
   public class QuestMapHandler_30019_421 extends DoorQuestMapHandler
   {
       
      
      public function QuestMapHandler_30019_421(param1:QuestProcessor)
      {
         questId = 30019;
         toSceneId = 86;
         _supportInstance = BinaryDoorSupport.getInstance();
         super(param1);
      }
   }
}
