package com.taomee.seer2.app.processor.quest.handler.main.quest12
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_12_301 extends QuestMapHandler
   {
       
      
      private var _mc_3:MovieClip;
      
      public function QuestMapHandler_12_301(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1))
         {
            this.addAnimation();
         }
         else
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         }
      }
      
      private function onQuestStep(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id,1))
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
            this.addAnimation();
         }
      }
      
      private function addMouseClickHint() : void
      {
         if(!QuestManager.isCompletable(_quest.id))
         {
            _processor.showMouseHintAt(127,287);
         }
      }
      
      private function addAnimation() : void
      {
         if(!QuestManager.isStepComplete(_quest.id,2))
         {
            this._mc_3 = _processor.resLib.getMovieClip("mc_3");
            _map.front.addChild(this._mc_3);
            MovieClipUtil.playMc(this._mc_3,1,this._mc_3.totalFrames,function():void
            {
               addMouseClickHint();
            },true);
         }
         else
         {
            this.addMouseClickHint();
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         _processor.hideMouseClickHint();
         if(this._mc_3)
         {
            DisplayObjectUtil.removeFromParent(this._mc_3);
         }
      }
   }
}
