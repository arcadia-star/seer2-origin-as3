package com.taomee.seer2.app.processor.quest.handler.branch.quest10136
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10136_213 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10136_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!isAccepted())
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
         if(isNeedCompleteStep(1))
         {
            this.initStep1();
         }
         if(isNeedCompleteStep(2))
         {
            this.initStep2();
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10136_0"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep);
            QuestManager.completeStep(questID,1);
         });
      }
      
      private function onCompleteStep(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
            if(param1.stepId == 2)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("BagginsLogPanel"),"","3");
            }
            if(param1.stepId == 1)
            {
               this.initStep2();
            }
         }
      }
      
      private function initStep2() : void
      {
         NpcDialog.show(27,"占卜婆婆",[[0,"日复一日，艾德华越来越羡慕被拥戴的哥哥。"]],[],[function():void
         {
            NpcDialog.show(27,"占卜婆婆",[[0,"直到有一天，艾德华认为世界上最重要的就是力量，只要拥有力量，就拥有了一切……"]],[],[function():void
            {
               NpcDialog.show(27,"占卜婆婆",[[0,"后来，他找到了目灵兽，祈求它能够将自己的身体治好，并且提升自己的力量！"]],[],[function():void
               {
                  NpcDialog.show(27,"占卜婆婆",[[0,"接下来的一切就是目灵兽留给世人的试炼，你若想了解更多就请亲身经历一次吧！"]],[],[function():void
                  {
                     NpcDialog.show(27,"占卜婆婆",[[0,"打开约瑟日志吧！，最后的试炼已经显示在日志之中了！"]],[],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep);
                        QuestManager.completeStep(questID,2);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
   }
}
