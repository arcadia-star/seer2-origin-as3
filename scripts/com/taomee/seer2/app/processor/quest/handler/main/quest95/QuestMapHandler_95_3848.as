package com.taomee.seer2.app.processor.quest.handler.main.quest95
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_95_3848 extends QuestMapHandler
   {
       
      
      private const NPC_ID:int = 3020;
      
      public function QuestMapHandler_95_3848(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false)
         {
            RightToolbarConter.instance.hide();
            if(QuestManager.isStepComplete(questID,4) && !QuestManager.isStepComplete(questID,5))
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("95_0"),function():void
               {
                  DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,onCustomReply);
               });
            }
         }
      }
      
      private function onCustomReply(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if(DialogPanelEventData(evt.content).params == "95_5")
         {
            NpcDialog.show(this.NPC_ID,"弗雷德",[[0,"我族历史悠久，从世界创造之初就作为原住民守护着阿卡迪亚大地的平衡。"]],["那为什么都没人见过你们呢？"],[function():void
            {
               NpcDialog.show(NPC_ID,"弗雷德",[[0,"我们喜欢居住在暗影中，这个世界惧怕黑暗，也惧怕我们，久而久之与我们失去了来往。但我们始终掌握着这个世界的动向，没有我们就没有现在的阿卡迪亚星。"]],["那你问什么要给我出谜语呢？"],[function():void
               {
                  NpcDialog.show(NPC_ID,"弗雷德",[[0,"影之誓言是为了寻找最有能力帮助我解决眼前麻烦的勇士，我亲自挑选了12名候选者，你是其中最快破解谜底的人。"]],["哈哈，我多聪明~"],[function():void
                  {
                     NpcDialog.show(NPC_ID,"弗雷德",[[0,"我相信你就是那个能帮我们的。"]],["你们遇到什么麻烦了嘛？"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("95_1"),function():void
                        {
                           QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                           QuestManager.completeStep(questID,5);
                        });
                     }]);
                  }]);
               }]);
            }]);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         RightToolbarConter.instance.show();
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         RightToolbarConter.instance.show();
      }
   }
}
