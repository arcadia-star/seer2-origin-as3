package com.taomee.seer2.app.processor.quest.handler.main.quest119
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_119_80603 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_119_80603(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         NpcDialog.showDialogsByText("quest/dialog/119/2.json",function():void
         {
            SceneManager.changeScene(SceneType.COPY,80604);
         },null);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
