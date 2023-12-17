package com.taomee.seer2.app.processor.quest.handler.story.quest18
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   
   public class QuestMapHandler_18_20 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_18_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var event:DialogCloseEvent = param1;
         if(event.params == "18_2")
         {
            ItemManager.requestItemList(function():void
            {
               if(ItemManager.getItemQuantityByReferenceId(400015) >= 1)
               {
                  DialogPanel.removeCloseEventListener(onShowAnimation);
                  NpcDialog.show(2,"伊娃",[[0,"恒温装置完成！！我会将它安装在你们的机体上。另外，我还会给你们安装一个生命勘测仪，相信它会给你们带来帮助的！"]],["（出发去冰之谷！）"],[function():void
                  {
                     QuestManager.completeStep(_quest.id,2);
                  }]);
               }
               else
               {
                  NpcDialog.show(2,"伊娃",[[0,"去蛮神战场找到“赤炎火苗”，否则装置无法运作！"]],["（去蛮神战场找找）"]);
               }
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
      }
   }
}
