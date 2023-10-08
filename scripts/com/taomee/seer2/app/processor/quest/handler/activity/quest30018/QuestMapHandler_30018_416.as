package com.taomee.seer2.app.processor.quest.handler.activity.quest30018
{
   import com.taomee.seer2.app.gameRule.door.hero.HeroDoorSupport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.activity.quest30015.DoorQuestMapHandler;
   
   public class QuestMapHandler_30018_416 extends DoorQuestMapHandler
   {
       
      
      public function QuestMapHandler_30018_416(param1:QuestProcessor)
      {
         questId = 30018;
         toSceneId = 85;
         _supportInstance = HeroDoorSupport.getInstance();
         super(param1);
      }
   }
}
