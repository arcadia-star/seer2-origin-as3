package com.taomee.seer2.app.processor.quest.handler.branch.quest10017
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   
   public class QuestMapHandler_10017_470 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10017_470(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
         else if(QuestManager.completeStep(_quest.id,1) == false)
         {
            QuestManager.completeStep(_quest.id,1);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var event:DialogCloseEvent = param1;
         var params:String = event.params;
         if(params == "10017_0")
         {
            NpcDialog.show(443,"埃卡维特",[[0,"听说有一种叫做赛尔豆的东西，你要是能给我一点，我就把高级钓竿送给你！"]],["给它500赛尔豆！","八成是骗钱的！"],[function():void
            {
               if(ActorManager.actorInfo.coins >= 500)
               {
                  NpcDialog.show(443,"埃卡维特",[[0,"哈哈，高级钓竿给你！原来这就是传说中的赛尔豆啊。"]],["钓鱼去咯！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                     QuestManager.accept(_quest.id);
                  }]);
               }
               else
               {
                  NpcDialog.show(443,"埃卡维特",[[0,"你的赛尔豆不够哦！ "]],["我先去赚点赛尔豆。"]);
               }
            },null]);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
            QuestManager.completeStep(_quest.id,1);
         }
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
      }
   }
}
