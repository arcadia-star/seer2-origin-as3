package com.taomee.seer2.app.processor.quest.handler.branch.quest10070
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   
   public class QuestMapHandler_10070_240 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10070_240(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         DialogPanel.addCloseEventListener(this.onCloseDialog);
      }
      
      private function onCloseDialog(param1:DialogCloseEvent) : void
      {
         if(param1.params == "10070")
         {
            this.startFight();
         }
      }
      
      private function startFight() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwictchComplete);
         FightManager.startFightWithWild(70);
      }
      
      private function onSwictchComplete(param1:SceneEvent) : void
      {
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex == 70)
            {
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwictchComplete);
               if(FightManager.fightWinnerSide == FightSide.RIGHT)
               {
                  NpcDialog.show(32,"洛克",[[4,"蛮神！！唯我独尊！！！"]],["继续继续！","还是算啦"],[function():void
                  {
                     startFight();
                  },null]);
               }
               else
               {
                  NpcDialog.show(32,"洛克",[[4,"额……胜败乃兵家常事！有胆量你明天再来！！"]],[" 哼哼，明天来还是一样的结果！"],[function():void
                  {
                     QuestManager.completeStep(_quest.id,1);
                     DialogPanel.addCloseEventListener(onCloseDialog);
                  }]);
               }
            }
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeCloseEventListener(this.onCloseDialog);
      }
   }
}
