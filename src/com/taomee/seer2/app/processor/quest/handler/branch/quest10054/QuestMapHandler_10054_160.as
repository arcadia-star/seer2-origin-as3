package com.taomee.seer2.app.processor.quest.handler.branch.quest10054
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   
   public class QuestMapHandler_10054_160 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10054_160(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         DialogPanel.addCloseEventListener(this.onCloseDialog);
      }
      
      private function onCloseDialog(param1:DialogCloseEvent) : void
      {
         var evt:DialogCloseEvent = param1;
         if(evt.params == "10054")
         {
            ItemManager.requestItemList(function():void
            {
               if(ItemManager.getItemQuantityByReferenceId(400009) > 0)
               {
                  NpcDialog.show(23,"洛水",[[0,"非常感谢你……希望明天你还能够为我采集一颗。水脉氏族的族人会记住你的名字。作为答谢，给你这个。"]],["嘿嘿，别客气。"],[function():void
                  {
                     QuestManager.completeStep(_quest.id,1);
                     DialogPanel.removeCloseEventListener(onCloseDialog);
                  }]);
               }
               else
               {
                  NpcDialog.show(23,"洛水",[[0,"你还没有得到夜明珠……再去找找吧！"]],["好的！"],[null]);
               }
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeCloseEventListener(this.onCloseDialog);
      }
   }
}
