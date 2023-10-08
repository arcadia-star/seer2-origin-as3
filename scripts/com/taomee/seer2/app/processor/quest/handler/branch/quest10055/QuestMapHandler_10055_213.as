package com.taomee.seer2.app.processor.quest.handler.branch.quest10055
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   
   public class QuestMapHandler_10055_213 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10055_213(param1:QuestProcessor)
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
         if(evt.params == "10055")
         {
            ItemManager.requestItemList(function():void
            {
               if(ItemManager.getItemQuantityByReferenceId(400013) > 0)
               {
                  NpcDialog.show(27,"邦妮婆婆",[[0,"咦嘿嘿……我好像又有灵感了！明天继续来为我收集食材吧！总有一天你会从食材中得到启示的！喏，这个拿去。"]],["灵感啊灵感……"],[function():void
                  {
                     QuestManager.completeStep(_quest.id,1);
                     DialogPanel.removeCloseEventListener(onCloseDialog);
                  }]);
               }
               else
               {
                  NpcDialog.show(27,"邦妮婆婆",[[0,"你还没有得到笑笑花子……再去找找吧！"]],["好的！"],[null]);
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
