package com.taomee.seer2.app.processor.quest.handler.branch.quest10168
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_10168_1090 extends QuestMapHandler
   {
      
      private static var _isFight:Boolean;
       
      
      public function QuestMapHandler_10168_1090(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && _isFight)
            {
               _isFight = false;
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
               QuestManager.completeStep(_quest.id,1);
               return;
            }
            DialogPanel.addCloseEventListener(this.onTeamLeaderDialogClosed);
         }
         else if(QuestManager.isCanAccepted(_quest.id))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            DialogPanel.addCloseEventListener(this.onTeamLeaderDialogClosed);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DialogPanel.removeCloseEventListener(this.onTeamLeaderDialogClosed);
      }
      
      private function onTeamLeaderDialogClosed(param1:DialogCloseEvent) : void
      {
         if(param1.params == "10168_0")
         {
            FightManager.startFightBinaryWild(274);
            _isFight = true;
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DialogPanel.removeCloseEventListener(this.onTeamLeaderDialogClosed);
      }
   }
}
