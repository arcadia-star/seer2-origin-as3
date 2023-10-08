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
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_30021_50 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30021_50(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onPlayMCHandler);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onNpcTalkHandler);
         }
      }
      
      private function onPlayMCHandler(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if((evt.content as DialogPanelEventData).params == "30021_2")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onPlayMCHandler);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30021_2"),2,[[1,0]],function():void
            {
               NpcDialog.show(1003,"多罗",[[0,"太可怕啦！！看来神秘队伍一定会获胜的！！！"]],["三个队长眼中的神秘人都不太一样么……"],[function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"多罗你放心，继续好好做你的队长，其他的事情交给我就好！"]],["看来，我要来个“夜探游戏室”了！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepTwoHandler);
                     QuestManager.completeStep(_quest.id,2);
                  }]);
               }]);
            });
         }
      }
      
      private function onNpcTalkHandler(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "30021_3")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onNpcTalkHandler);
            SceneManager.changeScene(SceneType.LOBBY,801);
         }
      }
      
      private function onStepTwoHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoHandler);
         SceneManager.changeScene(SceneType.LOBBY,801);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoHandler);
      }
   }
}
