package com.taomee.seer2.app.processor.quest.handler.branch.quest10071
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   
   public class QuestMapHandler_10071_230 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10071_230(param1:QuestProcessor)
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
         if(evt.params == "10071")
         {
            ItemManager.requestItemList(function():void
            {
               var cnt:int = ItemManager.getItemQuantityByReferenceId(400025);
               if(cnt >= 10)
               {
                  NpcDialog.show(35,"玛里",[[3,"哇~~真漂亮！！太感谢你啦！！下星期，下星期你还会来吧？嗯？嗯？"]],["哈哈，看时间吧！"],[function():void
                  {
                     QuestManager.completeStep(_quest.id,1);
                     DialogPanel.removeCloseEventListener(onCloseDialog);
                  }]);
               }
               else
               {
                  NpcDialog.show(35,"玛里",[[3,"你还没有得到足够的火神奖章哦！每周日的14:00-15:00和19:00-20:00，去赤炼山脉报名参加激斗吧！（已获得 " + cnt + "个火神奖章）"]],["好的！"],[null]);
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
