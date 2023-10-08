package com.taomee.seer2.app.processor.quest.handler.main.quest114
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_114_80583 extends QuestMapHandler
   {
       
      
      private var _dialogs:Array;
      
      public function QuestMapHandler_114_80583(param1:QuestProcessor)
      {
         this._dialogs = [[400,"小赛尔",[[0,"这……这是？巴蒂？神兽！  这这这是什么啊？！"]],["……"]],[11,"多罗",[[0,"巴蒂！巴蒂！你没事吧……我们找你找得好苦啊……咦？旁边那是什么？罐子里的又是什么？ 情况很复杂啊"]],["……"]],[400,"小赛尔",[[0,"（对着通讯器）第七小队……请求机……修和生物……疗支援"]],["……"]]];
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(!QuestManager.isAccepted(_quest.id))
         {
            return;
         }
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         if(QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initStep();
         }
      }
      
      private function initStep() : void
      {
         NpcDialog.showDialogs(this._dialogs,function():void
         {
            QuestManager.completeStep(questID,1);
            SceneManager.changeScene(SceneType.LOBBY,70);
         });
      }
   }
}
