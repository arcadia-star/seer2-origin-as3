package com.taomee.seer2.app.processor.quest.handler.branch.quest10161
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10161_160 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10161_160(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!isAccepted())
         {
            this.initAccept();
         }
         if(isNeedCompleteStep(1))
         {
            this.initStep1();
         }
      }
      
      private function initAccept() : void
      {
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         if(event.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10161_0"),5,[[1,0]],function():void
            {
               initStep1();
            });
         }
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(23,"洛水",[[0,"脉灵兽的血液不断污染着水脉氏族，被污染的精灵们也遭受着恐惧和疯狂的侵蚀。"]],[" 难道就没有办法了吗？ "],[function():void
         {
            NpcDialog.show(23,"洛水",[[0,"也不是没有办法，你可以让占卜婆婆带你回到那个时间，去看看那些被侵蚀的精灵们。"]],["  这就去找占卜婆婆 "],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep);
               QuestManager.completeStep(questID,1);
            }]);
         }]);
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1.questId == questID && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            SceneManager.changeScene(SceneType.LOBBY,213);
         }
      }
   }
}
