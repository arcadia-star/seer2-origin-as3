package com.taomee.seer2.app.processor.quest.handler.story.quest46
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
   
   public class QuestMapHandler_46_810 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_46_810(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "playComic46_810_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            this.playComic();
         }
      }
      
      private function playComic() : void
      {
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("46_0"),2,[[1,0]],function():void
         {
            NpcDialog.show(481,"耐普图隆",[[0,"据说，水温的反常升高，和能源之树的第四层有所关联。"]],["第四层，莫非是火系的那一层？"],[function():void
            {
               NpcDialog.show(481,"耐普图隆",[[0,"能源之树的第四层，火源通径。据说那里炎热不堪，但是照理说守护者会控制这一切才对。"]],["莫非那边出了什么事情？"],[function():void
               {
                  NpcDialog.show(481,"耐普图隆",[[0,"嗯……希望你可以去勘查一下究竟出了什么状况。"]],["太好奇了，我一定要去！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                     QuestManager.accept(_quest.id);
                  }]);
               }]);
            }]);
         });
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == 46)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY,820);
         }
      }
   }
}
