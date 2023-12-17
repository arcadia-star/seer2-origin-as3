package com.taomee.seer2.app.processor.quest.handler.activity.quest30023
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_30023_70 extends QuestMapHandler
   {
      
      public static const SIGN:String = "i_am_commissary_30023_70";
      
      public static const SIGN2:String = "57_0";
       
      
      public function QuestMapHandler_30023_70(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.acceptQuest);
         }
      }
      
      private function startTalk(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         if(event.questId == _quest.id)
         {
            DialogPanel.removeCloseEventListener(this.startTalk);
            NpcDialog.show(8,"艾农",[[1,"GO GO GO啊来啊来啊来！一年一度的精灵王争霸赛可谓是热闹非凡啊！对了，你被当选为你们队的宣传委员啦！"]],["额……宣传委员"],[function():void
            {
               NpcDialog.show(8,"艾农",[[1,"还愣着干嘛！快去船长那里报到吧！他正在船长室等候你呢！记得扬你队威哦！哈哈！"]],["（是！我这就去！）"],[function():void
               {
                  QuestManager.accept(_quest.id);
                  QuestManager.addEventListener(QuestEvent.ACCEPT,acceptQuest);
               }]);
            }]);
         }
      }
      
      private function acceptQuest(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.acceptQuest);
            SceneManager.changeScene(SceneType.LOBBY,10);
         }
      }
   }
}
