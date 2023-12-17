package com.taomee.seer2.app.processor.quest.handler.branch.quest10130
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10130_301 extends QuestMapHandler
   {
       
      
      private var _mc_4:MovieClip;
      
      private var _dialog4:MovieClip;
      
      private var _zhi:MovieClip;
      
      public function QuestMapHandler_10130_301(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.playAnimation();
         }
      }
      
      private function playAnimation() : void
      {
         this._mc_4 = _processor.resLib.getMovieClip("step4");
         LayerManager.topLayer.addChild(this._mc_4);
         MovieClipUtil.playMc(this._mc_4,2,this._mc_4.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mc_4);
            _processor.showMouseHintAt(515,324);
            _zhi = _processor.resLib.getMovieClip("zhi4");
            _map.content.addChild(_zhi);
            _zhi.buttonMode = true;
            _zhi.addEventListener(MouseEvent.CLICK,onZhi);
         },true);
      }
      
      private function onZhi(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DisplayUtil.removeForParent(this._zhi);
         _processor.hideMouseClickHint();
         this._dialog4 = _processor.resLib.getMovieClip("dialog4");
         LayerManager.topLayer.addChild(this._dialog4);
         MovieClipUtil.playMc(this._dialog4,2,this._dialog4.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_dialog4);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(_quest.id,4);
         },true);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         _processor.showMouseHintAt(828,453);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._zhi);
         DisplayUtil.removeForParent(this._mc_4);
         DisplayUtil.removeForParent(this._dialog4);
         this._mc_4 = null;
         this._zhi = null;
         this._dialog4 = null;
      }
   }
}
