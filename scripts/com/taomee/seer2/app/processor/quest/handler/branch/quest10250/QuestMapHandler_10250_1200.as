package com.taomee.seer2.app.processor.quest.handler.branch.quest10250
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   
   public class QuestMapHandler_10250_1200 extends QuestMapHandler
   {
       
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function QuestMapHandler_10250_1200(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isComplete(10250) == false)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         }
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1 == null || param1.questId == 10250 && param1.stepId == 4)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = 745;
            this._mouseHint.y = 263;
            _map.front.addChild(this._mouseHint);
         }
      }
   }
}
