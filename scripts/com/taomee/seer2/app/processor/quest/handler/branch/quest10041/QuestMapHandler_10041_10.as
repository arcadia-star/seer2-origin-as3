package com.taomee.seer2.app.processor.quest.handler.branch.quest10041
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_10041;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.manager.GlobalsManager;
   import com.taomee.seer2.core.manager.TimeManager;
   
   public class QuestMapHandler_10041_10 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10041_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         if(param1.content.params == "GFTask")
         {
            this.doGFTask();
         }
      }
      
      public function doGFTask() : void
      {
         var data:Date = new Date(TimeManager.getServerTime() * 1000);
         if(data.getDay() != 6 && data.getDay() != 0 || data.getHours() < 13 || data.getHours() > 15)
         {
            NpcDialog.show(1,"船长辛迪",[[0,"活动开放时间: 周六周日13-15点"]],["好的，我知道了。"]);
            return;
         }
         if(QuestManager.isAccepted(QuestProcessor_10041.TASK_ID))
         {
            if(QuestManager.isStepComplete(QuestProcessor_10041.TASK_ID,1))
            {
               NpcDialog.show(1,"船长辛迪",[[0,"做得非常好，回到功夫派后你就可以获得奖励咯，我们非常欢迎你继续留在赛尔号2里进行全新的冒险。"]],["再见"],[function():void
               {
                  QuestManager.completeStep(QuestProcessor_10041.TASK_ID,2);
               }]);
            }
            else
            {
               NpcDialog.show(1,"船长辛迪",[[0,"来自艾尔大陆的勇士啊，你还没有击败那个在巨石洞穴肆虐的SPT-BOSS布鲁托吗？"]],["好的，我很愿意。"]);
            }
         }
         else if(GlobalsManager.isFromGF)
         {
            Connection.send(CommandSet.SERVER_TYPE_1183,GlobalsManager.otherServerType - 1);
            NpcDialog.show(1,"船长辛迪",[[0,"你好，你是来自外艾尔大陆的勇士吧，如果想要获得奖励就要努力修炼，击败布鲁托来证明自己吧，将伊特晶石带回飞船吧。"]],["我会努力的！"],[function():void
            {
               QuestManager.accept(QuestProcessor_10041.TASK_ID);
            }]);
         }
         else
         {
            NpcDialog.show(1,"船长辛迪",[[0,"只有从功夫派过来的玩家才可以接这个任务哦"]],["再见"]);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
      }
   }
}
