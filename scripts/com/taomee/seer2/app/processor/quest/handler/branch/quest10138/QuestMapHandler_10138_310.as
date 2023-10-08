package com.taomee.seer2.app.processor.quest.handler.branch.quest10138
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10138_310 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10138_310(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.playFull();
         }
      }
      
      private function playFull() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10138_2"),function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("SaveChickenPanel"),"正在打开面板...");
            ModuleManager.addEventListener("SaveChickenPanel","ChickenRight",onRightHandler);
         },true,false,2);
      }
      
      private function onRightHandler(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("SaveChickenPanel","ChickenRight",this.onRightHandler);
         this.playFullAgain();
      }
      
      private function playFullAgain() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10138_3"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onStep3Handler);
            QuestManager.completeStep(_quest.id,3);
         },true,false,2);
      }
      
      private function onStep3Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep3Handler);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep3Handler);
         ModuleManager.removeEventListener("SaveChickenPanel","ChickenRight",this.onRightHandler);
      }
   }
}
