package com.taomee.seer2.app.processor.quest.handler.story.quest18
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_18_10 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_18_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var event:DialogCloseEvent = param1;
         if(event.params == "18_1")
         {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("18_1"),3,[[1,0]],function():void
            {
               NpcDialog.show(1,"辛迪船长",[[0,"伊娃博士今天递交了一份报告，说她已经研制出了一种恒温装置，能够让赛尔的机体在严寒下正常运作。"]],["真是太好了！"],[function():void
               {
                  NpcDialog.show(1,"辛迪船长",[[0,"现在，我正式任命你们为“冰沁氏族勘探特派小队”！这件事情，就拜托你们几个了！"]],["遵命！（去实验室找伊娃博士！）"],[function():void
                  {
                     QuestManager.completeStep(_quest.id,1);
                  }]);
               }]);
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
      }
   }
}
