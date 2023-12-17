package com.taomee.seer2.app.processor.quest.handler.activity.quest30021
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_30021_40 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30021_40(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onPlayMCHandler);
         }
      }
      
      private function onPlayMCHandler(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if((evt.content as DialogPanelEventData).params == "30021_1")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onPlayMCHandler);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30021_1"),2,[[1,0]],function():void
            {
               NpcDialog.show(1002,"上尉",[[0,"不过神秘人好似异常胆小！哼，这样的胆量也敢出来搅局？？"]],["呃，怎么觉得和伊娃博士描述的不是同一人？"],[function():void
               {
                  NpcDialog.show(1002,"上尉",[[0,"哎？是吗？你可以去询问一下丛林队的队长，看看他有什么线索。"]],["好吧！（去丛林队！）"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepOneHandler);
                     QuestManager.completeStep(_quest.id,1);
                  }]);
               }]);
            });
         }
      }
      
      private function onStepOneHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneHandler);
         SceneManager.changeScene(SceneType.LOBBY,50);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneHandler);
      }
   }
}
