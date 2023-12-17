package com.taomee.seer2.app.processor.quest.handler.activity.quest30015
{
   import com.taomee.seer2.app.gameRule.door.trails.TrailDoorSupport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   
   public class QuestMapHandler_30015_400 extends DoorQuestMapHandler
   {
       
      
      public function QuestMapHandler_30015_400(param1:QuestProcessor)
      {
         questId = 30015;
         toSceneId = 82;
         _supportInstance = TrailDoorSupport.getInstance();
         super(param1);
      }
   }
}
