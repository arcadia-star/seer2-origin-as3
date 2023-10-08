package com.taomee.seer2.app.processor.quest.handler.branch.quest10132
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10132_213 extends FindSheetQuest
   {
       
      
      public function QuestMapHandler_10132_213(param1:QuestProcessor)
      {
         stepId = 2;
         fightId = 185;
         petId = 27;
         itemId = 400246;
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onFirstFightHandler);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccetpt);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!isAccepted())
         {
            this.showDia();
         }
      }
      
      private function showDia() : void
      {
         NpcDialog.show(400,"我",[[0,"约瑟日志怎么把我指引到这个地方了？"]],[],[function():void
         {
            NpcDialog.show(400,"我",[[0,"传说中高贵善良的玛雅族公主在这里吗？？？"]],[],[function():void
            {
               NpcDialog.show(400,"我",[[0,"不可能！不可能！这里只有一个贪吃又花痴的老太婆！不过过去问问也许人家知道的多呢。还是过去问问吧。"]],[],[function():void
               {
                  DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,onFirstFightHandler);
               }]);
            }]);
         }]);
      }
      
      private function onFirstFightHandler(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if((evt.content as DialogPanelEventData).params == "playFulll10132_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onFirstFightHandler);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10132_0"),function():void
            {
               NpcDialog.show(27,"占卜婆婆",[[1,"打开你的约瑟日志吧！这里已经有了新的指引！跟着指引走下去，你需要的答案都将一个个的揭晓！"]],["那残卷都藏在哪里？"],[function():void
               {
                  NpcDialog.show(27,"占卜婆婆",[[1,"残卷就藏在水脉氏族中的精灵身上，跟精灵对战就有可能捡到残卷哦。寡人身子骨老了，行动不便，你自己去吧！"]],["谢谢你啦！老人家！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAccetpt);
                     QuestManager.accept(questID);
                  }]);
               }]);
            },true,true);
         }
      }
      
      private function onAccetpt(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.accept(10133);
         }
         if(param1.questId == 10133)
         {
            QuestManager.accept(10134);
         }
         if(param1.questId == 10134)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccetpt);
            ModuleManager.toggleModule(URLUtil.getAppModule("EyeBeastPanel"),"打开中","2");
         }
      }
   }
}
