package com.taomee.seer2.app.processor.quest.handler.branch.quest10229
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10229_920 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10229_920(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.initStep2();
         }
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1.questId == 10229)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            this.initStep2();
         }
      }
      
      private function initStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10229_1"),function():void
         {
            NpcDialog.show(106,"斯坦因",[[1,"如果我没猜错的话，轮轴应该就散落在风刃氏族的各个区域，" + ActorManager.actorInfo.nick + "，去努力找找吧。"]],["好的！"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               QuestManager.completeStep(questID,2);
            }]);
         });
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10229)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            ModuleManager.showAppModule("TongHunBeastPanel","2");
         }
      }
   }
}
