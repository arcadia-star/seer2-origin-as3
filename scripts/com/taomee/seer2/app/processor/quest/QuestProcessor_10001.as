package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   
   public class QuestProcessor_10001 extends QuestProcessor
   {
      
      private static const DREAM_MAP:Array = [137,138,139];
       
      
      public function QuestProcessor_10001(param1:Quest)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
      }
      
      private function onMapComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active && SceneManager.active.type != SceneType.ARENA && this.isBackFromDream() && this.isQuestStep1())
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
            QuestManager.completeStep(_quest.id,1);
         }
      }
      
      private function isQuestStep1() : Boolean
      {
         return _quest.status == QuestStatus.IN_PROGRESS && !_quest.isStepCompete(1);
      }
      
      private function isBackFromDream() : Boolean
      {
         return DREAM_MAP.indexOf(SceneManager.prevMapID) != -1;
      }
      
      override public function dispose() : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
         super.dispose();
      }
   }
}
