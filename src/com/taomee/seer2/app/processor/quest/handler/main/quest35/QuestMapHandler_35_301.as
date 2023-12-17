package com.taomee.seer2.app.processor.quest.handler.main.quest35
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_35_301 extends QuestMapHandler
   {
       
      
      private var _fightStatus:int = 0;
      
      public function QuestMapHandler_35_301(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA && this._fightStatus == 1)
         {
            this._fightStatus = 0;
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.win();
               return;
            }
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "35_2")
         {
            this._fightStatus = 1;
            FightManager.startFightWithWild(68);
         }
      }
      
      private function win() : void
      {
         NpcDialog.show(33,"奥拉",[[1,"我说！我说！你饶了我吧……你沿着灰烬岔口走，那里有一个通往深渊的入口！！你别告诉洛克是我告诉你的……"]],["早说不就得了！"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(_quest.id,2);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            _processor.showMouseHintAt(88,293);
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         _processor.hideMouseClickHint();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
   }
}
