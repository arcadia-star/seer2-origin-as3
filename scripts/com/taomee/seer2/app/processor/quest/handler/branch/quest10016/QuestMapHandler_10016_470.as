package com.taomee.seer2.app.processor.quest.handler.branch.quest10016
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_10016_470 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10016_470(param1:QuestProcessor)
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
         else if(QuestManager.isStepComplete(_quest.id,1) == false)
         {
            QuestManager.completeStep(_quest.id,1);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var event:DialogCloseEvent = param1;
         var params:String = event.params;
         if(params == "10016_0")
         {
            NpcDialog.show(443,"埃卡维特",[[0,"我最喜欢收集千奇百怪的东西了，你能帮我去找两个蘑菇果实么？"]],["我这就去！","我身上就有。"],[null,function():void
            {
               ItemManager.requestItemList(function():void
               {
                  if(ItemManager.getItemQuantityByReferenceId(400008) >= 2)
                  {
                     NpcDialog.show(443,"埃卡维特",[[0,"太棒了！作为感谢，这是给你的10条赤焰小鱼！快用它去赤炼山脉垂钓点钓鱼吧。你一定会邂逅神秘火系精灵的。"]],["好咧，现在就去！"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                        QuestManager.accept(_quest.id);
                     }]);
                  }
                  else
                  {
                     NpcDialog.show(443,"埃卡维特",[[0,"你还没有找到蘑菇果实么，在幻影崖或者异蘑小径都可以找到它"]],["我这就去！"]);
                  }
               });
            }]);
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
         SceneManager.changeScene(SceneType.LOBBY,261);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
   }
}
