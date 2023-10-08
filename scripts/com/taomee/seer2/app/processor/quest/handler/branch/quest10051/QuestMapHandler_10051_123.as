package com.taomee.seer2.app.processor.quest.handler.branch.quest10051
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
   
   public class QuestMapHandler_10051_123 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10051_123(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addCloseEventListener(this.onCloseDialog);
         }
         else
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         }
      }
      
      private function onQuestAccept(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
            NpcDialog.show(20,"舒尔",[[1,"藤蔓花非常漂亮！我想自己好好种植，等妈妈回来后就送给她！"]],["我这里就有哦！给你！","我去帮你找吧！"],[this.giveToYou,this.findToYou]);
         }
      }
      
      private function onCloseDialog(param1:DialogCloseEvent) : void
      {
         if(param1.params == "10051_0")
         {
            this.giveToYou();
         }
         else if(param1.params == "10051_1")
         {
            this.findToYou();
         }
      }
      
      private function giveToYou() : void
      {
         ItemManager.requestItemList(function():void
         {
            if(ItemManager.getItemQuantityByReferenceId(400010) > 0)
            {
               NpcDialog.show(20,"舒尔",[[1,"好宝贵的生日礼物！你是我的福星！作为报答，我要送给你一点小礼物~"]],["嘿嘿，谢谢啦~"],[function():void
               {
                  QuestManager.completeStep(_quest.id,1);
               }]);
            }
            else
            {
               NpcDialog.show(20,"舒尔",[[1,"嗯……果然是很难得到的种子吗……"]],["（我记得藤蔓花子在水仙草界！）"],[null]);
            }
         });
      }
      
      private function findToYou() : void
      {
         NpcDialog.show(20,"舒尔",[[1,"太好啦！太好啦！！"]],["（我记得藤蔓花子在水仙草界！）"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,151);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeCloseEventListener(this.onCloseDialog);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
      }
   }
}
