package com.taomee.seer2.app.processor.quest.handler.main.quest5
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_5;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_5_133 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_5_133(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(4))
         {
            this.processStep4();
         }
      }
      
      private function processStep4() : void
      {
         DialogPanel.showForSimple(NpcUtil.getSeerNpcId(),"我",[[0,"这里的气氛有点怪啊！坏蛋肯定就在附近！"]],"我要镇定……",function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("5/quest5Animation2"),function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete4);
               QuestManager.completeStep(_quest.id,4);
            },false);
         });
      }
      
      private function onStepComplete4(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete4);
            QuestProcessor_5(_processor).removeSubstitute();
            SceneManager.changeScene(SceneType.LOBBY,110);
         }
      }
      
      override public function processMapDispose() : void
      {
      }
   }
}
