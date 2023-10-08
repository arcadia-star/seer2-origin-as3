package com.taomee.seer2.app.processor.quest.handler.branch.quest10218
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10218_80130 extends QuestMapHandler
   {
       
      
      private var _animationBtn:SimpleButton;
      
      private var _count:uint;
      
      public function QuestMapHandler_10218_80130(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10218) && QuestManager.isStepComplete(10218,5) == false)
         {
            this.initStep5();
         }
      }
      
      private function initStep5() : void
      {
         _processor.showMouseHintAt(670,117);
         this._count = 0;
         this._animationBtn = _map.content["mc_8123asdfds"];
         this._animationBtn.addEventListener(MouseEvent.CLICK,this.onAnimation);
      }
      
      private function onAnimation(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this._count == 0)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_4"),function():void
            {
               ++_count;
            },true,true);
         }
         else if(this._count > 0)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_5"),function():void
            {
               _processor.hideMouseClickHint();
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
               QuestManager.completeStep(10218,5);
            },true,true);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.COPY,80131);
      }
      
      override public function processMapDispose() : void
      {
         this._animationBtn.removeEventListener(MouseEvent.CLICK,this.onAnimation);
         _processor.hideMouseClickHint();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         super.processMapDispose();
      }
   }
}
