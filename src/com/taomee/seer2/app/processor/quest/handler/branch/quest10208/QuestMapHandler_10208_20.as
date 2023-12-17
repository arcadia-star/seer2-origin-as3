package com.taomee.seer2.app.processor.quest.handler.branch.quest10208
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10208_20 extends QuestMapHandler
   {
       
      
      private const NPC_ID:int = 346;
      
      private var sceneMc:MovieClip;
      
      private var guidMc:MovieClip;
      
      private var clickZone:MovieClip;
      
      public function QuestMapHandler_10208_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedCompleteStep(1))
         {
            this.onStep1();
         }
         if(isNeedCompleteStep(2) && !QuestManager.isComplete(10208))
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("PetDeityRewardPanel"));
         }
      }
      
      private function onStep1() : void
      {
         this.sceneMc = _processor.resLib.getMovieClip("NoNoSay");
         this.sceneMc.mouseChildren = this.sceneMc.mouseEnabled = false;
         _map.front.addChild(this.sceneMc);
         _map.content["shenMo"].addEventListener(MouseEvent.CLICK,this.clearMc,false,1000);
      }
      
      private function clearMc(param1:MouseEvent) : void
      {
         DisplayObjectUtil.removeFromParent(this.sceneMc);
         this.sceneMc.stop();
         param1.stopImmediatePropagation();
         this.showGuid();
      }
      
      private function showGuid() : void
      {
         this.guidMc = _processor.resLib.getMovieClip("GuidMc");
         this.guidMc.gotoAndStop(1);
         this.clickZone = this.guidMc["clickZone"];
         this.clickZone.buttonMode = true;
         this.clickZone.addEventListener(MouseEvent.CLICK,this.nextFrame);
         LayerManager.topLayer.addChild(this.guidMc);
         LayerManager.hideMap();
      }
      
      private function nextFrame(param1:MouseEvent) : void
      {
         this.guidMc.nextFrame();
         this.clickZone.removeEventListener(MouseEvent.CLICK,this.nextFrame);
         this.clickZone = this.guidMc["clickZone"];
         this.clickZone.buttonMode = true;
         this.clickZone.addEventListener(MouseEvent.CLICK,this.nextFrame);
         if(this.guidMc.currentFrame == this.guidMc.totalFrames)
         {
            this.clickZone.addEventListener(MouseEvent.CLICK,this.toCompleteStep);
         }
         else
         {
            this.clickZone.addEventListener(MouseEvent.CLICK,this.nextFrame);
         }
      }
      
      protected function toCompleteStep(param1:MouseEvent) : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.completeStep1);
         QuestManager.completeStep(questID,1);
      }
      
      private function completeStep1(param1:QuestEvent) : void
      {
         if(param1.questId == questID && param1.stepId == 1)
         {
            DisplayObjectUtil.removeFromParent(this.guidMc);
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.completeStep1);
            ModuleManager.toggleModule(URLUtil.getAppModule("PetDeityRewardPanel"));
            LayerManager.showMap();
            _map.content["shenMo"].removeEventListener(MouseEvent.CLICK,this.clearMc);
         }
      }
      
      override public function processMapDispose() : void
      {
         _map.content["shenMo"].removeEventListener(MouseEvent.CLICK,this.clearMc);
         super.processMapDispose();
      }
   }
}
