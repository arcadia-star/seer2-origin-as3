package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.miniGame.MiniGameEvent;
   import com.taomee.seer2.app.miniGame.MiniGameManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.Quest;
   
   public class QuestProcessor_10007 extends QuestProcessor
   {
       
      
      public function QuestProcessor_10007(param1:Quest)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         MiniGameManager.addEventListener(MiniGameEvent.END_PLAY_GAME,this.onGameOver);
      }
      
      private function onGameOver(param1:MiniGameEvent) : void
      {
         if(param1.gameId == 4)
         {
            MiniGameManager.removeEventListener(MiniGameEvent.END_PLAY_GAME,this.onGameOver);
            QuestManager.completeStep(_quest.id,2);
         }
      }
   }
}
