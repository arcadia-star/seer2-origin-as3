package com.taomee.seer2.app.processor.quest.handler.branch.quest10177
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_10177_302 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10177_302(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedToAccept())
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY,470);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
   }
}
