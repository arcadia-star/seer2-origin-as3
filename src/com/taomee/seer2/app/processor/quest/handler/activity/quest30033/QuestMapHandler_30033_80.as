package com.taomee.seer2.app.processor.quest.handler.activity.quest30033
{
   import com.taomee.seer2.app.miniGame.MiniGameEvent;
   import com.taomee.seer2.app.miniGame.MiniGameManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_30033_80 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30033_80(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            MiniGameManager.addEventListener(MiniGameEvent.END_PLAY_GAME,this.onEndtMinGame);
         }
      }
      
      private function onEndtMinGame(param1:MiniGameEvent) : void
      {
         MiniGameManager.removeEventListener(MiniGameEvent.END_PLAY_GAME,this.onEndtMinGame);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.completeStep(_quest.id,1);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("xegg/xegg2"),function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("XeggPanel"),"正在打开面板...");
         },true,true,2);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         MiniGameManager.removeEventListener(MiniGameEvent.END_PLAY_GAME,this.onEndtMinGame);
      }
   }
}
