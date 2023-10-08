package com.taomee.seer2.app.processor.quest.handler.main.quest121
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_121_80611 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_121_80611(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         NpcDialog.showDialogsByText("quest/dialog/121/7.json",function():void
         {
            QuestManager.completeStep(questID,1);
            SceneManager.changeScene(SceneType.LOBBY,70);
         },null);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
