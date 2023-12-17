package com.taomee.seer2.app.processor.quest.handler.main.quest116
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_116_80589 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_116_80589(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         this.initStep1();
      }
      
      private function initStep1() : void
      {
         NpcDialog.showDialogsByText("quest/dialog/116/2.json",function():void
         {
            SceneManager.changeScene(SceneType.COPY,80590);
         },null);
      }
   }
}
