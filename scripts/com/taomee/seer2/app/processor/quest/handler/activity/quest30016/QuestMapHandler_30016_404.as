package com.taomee.seer2.app.processor.quest.handler.activity.quest30016
{
   import com.taomee.seer2.app.gameRule.door.warrior.WarriorDoorSuport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.activity.quest30015.DoorQuestMapHandler;
   
   public class QuestMapHandler_30016_404 extends DoorQuestMapHandler
   {
       
      
      public function QuestMapHandler_30016_404(param1:QuestProcessor)
      {
         questId = 30016;
         toSceneId = 83;
         _supportInstance = WarriorDoorSuport.getInstance();
         super(param1);
      }
   }
}
