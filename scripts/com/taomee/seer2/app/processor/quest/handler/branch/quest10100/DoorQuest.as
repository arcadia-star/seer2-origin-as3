package com.taomee.seer2.app.processor.quest.handler.branch.quest10100
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class DoorQuest extends QuestMapHandler
   {
       
      
      public function DoorQuest(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.isWinWar())
         {
            QuestManager.completeStep(_quest.id,1);
         }
      }
   }
}
