package com.taomee.seer2.app.processor.quest.handler.main.quest6
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_6_122 extends QuestMapHandler
   {
       
      
      private var _animationStep5:MovieClip;
      
      public function QuestMapHandler_6_122(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(Boolean(_quest.isStepCompete(4)) && !_quest.isStepCompete(5))
         {
            this.processStep5();
         }
      }
      
      private function processStep5() : void
      {
         this._animationStep5 = _map.content["quest_6_5"];
         MovieClipUtil.playMc(this._animationStep5,2,this._animationStep5.totalFrames,function():void
         {
            _processor.showMouseHintAt(100,130);
            QuestManager.completeStep(_quest.id,5);
         },true);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
   }
}
