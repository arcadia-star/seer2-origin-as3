package com.taomee.seer2.app.processor.quest.handler.story.quest16
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_16_310 extends QuestMapHandler
   {
       
      
      private var _mc_2:MovieClip;
      
      public function QuestMapHandler_16_310(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.showMC2();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isComplete(_quest.id) == false)
         {
            this.addMouseClickHint();
         }
      }
      
      private function showMC2() : void
      {
         this._mc_2 = _processor.resLib.getMovieClip("mc_2");
         _map.front.addChild(this._mc_2);
         MovieClipUtil.playMc(this._mc_2,1,this._mc_2.totalFrames,function():void
         {
            _mc_2.buttonMode = true;
            _mc_2.addEventListener(MouseEvent.CLICK,onMC2Click);
         },true);
      }
      
      private function onMC2Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_2.removeEventListener(MouseEvent.CLICK,this.onMC2Click);
         NpcDialog.show(11,"多罗",[[2,"布条！肯定是它！队长，我们还是不要追了！"]],["……"],[function():void
         {
            NpcDialog.show(10,"巴蒂",[[0,"嗯嗯……看来没有错，队长，我们去沙爪氏族主城看看吧！"]],["出发！"],[function():void
            {
               DisplayUtil.removeForParent(_mc_2);
               _mc_2 = null;
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onQuestStep);
               QuestManager.completeStep(_quest.id,1);
            }]);
         }]);
      }
      
      private function onQuestStep(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         this.addMouseClickHint();
      }
      
      private function addMouseClickHint() : void
      {
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isCompletable(_quest.id))
         {
            _processor.showMouseHintAt(610,425);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._mc_2);
         this._mc_2 = null;
      }
   }
}
