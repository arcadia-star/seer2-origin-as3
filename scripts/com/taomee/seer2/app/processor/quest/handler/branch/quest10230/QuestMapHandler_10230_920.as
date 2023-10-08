package com.taomee.seer2.app.processor.quest.handler.branch.quest10230
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10230_920 extends QuestMapHandler
   {
      
      public static var haveStep:Boolean = false;
       
      
      public function QuestMapHandler_10230_920(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!isAccepted())
         {
            this.initAccept();
         }
         else if(QuestManager.isComplete(10230) == false)
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
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(106,"斯坦因",[[1,"找到瞳之门，首先需要有风之力的帮助。"]],[" 风之力？那是什么？ "],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10230_0"),initStep2);
         }]);
      }
      
      private function initStep2() : void
      {
         NpcDialog.show(106,"斯坦因",[[1,"风之力就是风系氏族精灵身上所存在的力场，必须先收集齐一定数量的风系精灵才行。"]],[" 好！我现在就去！ "],[function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onStep);
            QuestManager.completeStep(questID,1);
         }]);
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep);
         ModuleManager.showAppModule("TongHunBeastPanel","3");
      }
   }
}
