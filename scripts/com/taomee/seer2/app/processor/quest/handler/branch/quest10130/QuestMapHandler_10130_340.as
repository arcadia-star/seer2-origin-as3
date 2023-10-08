package com.taomee.seer2.app.processor.quest.handler.branch.quest10130
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.animation.QuestCompleteAnimation;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10130_340 extends QuestMapHandler
   {
       
      
      private var _mc_6:MovieClip;
      
      private var _zhi:MovieClip;
      
      private var _maliangGame:com.taomee.seer2.app.processor.quest.handler.branch.quest10130.MaliangGame;
      
      private var _mc_7:MovieClip;
      
      private var _alert:MovieClip;
      
      private var _maliang:MovieClip;
      
      private var _currStep:int;
      
      private var _game2:com.taomee.seer2.app.processor.quest.handler.branch.quest10130.Game10130;
      
      public function QuestMapHandler_10130_340(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,5) && QuestManager.isStepComplete(_quest.id,6) == false)
         {
            this.playAnimation();
         }
         if(QuestManager.isStepComplete(_quest.id,6) && QuestManager.isStepComplete(_quest.id,7) == false)
         {
            this.processor7();
         }
         if(QuestManager.isStepComplete(_quest.id,7) && QuestManager.isStepComplete(_quest.id,8) == false)
         {
            this._currStep = 0;
            this.processor8();
         }
         if(QuestManager.isStepComplete(_quest.id,8) && QuestManager.isStepComplete(_quest.id,9) == false)
         {
            this._currStep = 1;
            this.processor8();
         }
         if(QuestManager.isStepComplete(_quest.id,9) && QuestManager.isStepComplete(_quest.id,10) == false)
         {
            this._currStep = 2;
            this.processor8();
         }
      }
      
      private function playAnimation() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10130_0"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(_quest.id,6);
         },true,false,2);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(param1.stepId == 6)
         {
            this.processor7();
         }
         if(param1.stepId == 7)
         {
            this._currStep = 0;
            this.processor8();
         }
         if(param1.stepId == 8)
         {
            this._currStep = 1;
            this.processor8();
         }
         if(param1.stepId == 9)
         {
            this._currStep = 2;
            this.processor8();
         }
      }
      
      private function processor7() : void
      {
         _processor.showMouseHintAt(453,470);
         this._zhi = _processor.resLib.getMovieClip("zhi6or7");
         _map.content.addChild(this._zhi);
         this._zhi.buttonMode = true;
         this._zhi.addEventListener(MouseEvent.CLICK,this.onZhi);
      }
      
      private function onZhi(param1:MouseEvent) : void
      {
         this._maliangGame = new com.taomee.seer2.app.processor.quest.handler.branch.quest10130.MaliangGame(_processor.resLib.getMovieClip("maliangGame"),this.gameComplete);
      }
      
      private function gameComplete() : void
      {
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._zhi);
         this._maliangGame.dispose(null);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10130_1"),function():void
         {
            _maliang = _processor.resLib.getMovieClip("maliang");
            LayerManager.topLayer.addChild(_maliang);
            _mc_7 = _processor.resLib.getMovieClip("step7");
            LayerManager.topLayer.addChild(_mc_7);
            MovieClipUtil.playMc(_mc_7,2,_mc_7.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_mc_7);
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
               QuestManager.completeStep(_quest.id,7);
               _currStep = 0;
               showAlert();
            },true);
         },true,false,2);
      }
      
      private function processor8() : void
      {
         if(this._maliang == null)
         {
            this._maliang = _processor.resLib.getMovieClip("maliang");
         }
         if(this._alert == null || this._alert.parent == null)
         {
            _processor.showMouseHintAt(378,402);
         }
         LayerManager.topLayer.addChild(this._maliang);
         this._maliang.buttonMode = true;
         this._maliang.addEventListener(MouseEvent.CLICK,this.onMaliang);
      }
      
      private function onMaliang(param1:MouseEvent) : void
      {
         if(QuestManager.isStepComplete(_quest.id,7) && QuestManager.isStepComplete(_quest.id,8) == false)
         {
            this._currStep = 0;
         }
         if(QuestManager.isStepComplete(_quest.id,8) && QuestManager.isStepComplete(_quest.id,9) == false)
         {
            this._currStep = 1;
         }
         if(QuestManager.isStepComplete(_quest.id,9) && QuestManager.isStepComplete(_quest.id,10) == false)
         {
            this._currStep = 2;
         }
         this.showAlert();
      }
      
      private function showAlert() : void
      {
         this._maliang.mouseChildren = false;
         this._maliang.mouseEnabled = false;
         _processor.hideMouseClickHint();
         this._alert = _processor.resLib.getMovieClip("alert");
         LayerManager.topLayer.addChild(this._alert);
         LayerManager.focusOnTopLayer();
         DisplayUtil.align(this._alert,4,LayerManager.rootRect);
         this._alert["bi"].addEventListener(MouseEvent.CLICK,this.onBi);
      }
      
      private function onBi(param1:MouseEvent) : void
      {
         _processor.showMouseHintAt(378,402);
         LayerManager.resetOperation();
         this._maliang.mouseChildren = true;
         this._maliang.mouseEnabled = true;
         DisplayUtil.removeForParent(this._alert);
         this.game2();
      }
      
      private function game2() : void
      {
         this._game2 = new com.taomee.seer2.app.processor.quest.handler.branch.quest10130.Game10130(_processor.resLib.getMovieClip("game2"),this._currStep,this.game2Complete);
      }
      
      private function game2Complete() : void
      {
         this._game2.dispose(null);
         LayerManager.resetOperation();
         DisplayUtil.removeForParent(this._maliang);
         DisplayUtil.removeForParent(this._alert);
         DisplayUtil.removeForParent(this._mc_6);
         DisplayUtil.removeForParent(this._mc_7);
         DisplayUtil.removeForParent(this._zhi);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10130_2"),function():void
         {
            var _loc1_:QuestCompleteAnimation = new QuestCompleteAnimation();
            _loc1_.play();
         },true,false,2);
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(this._game2)
         {
            this._game2.dispose(null);
         }
         if(this._maliangGame)
         {
            this._maliangGame.dispose(null);
         }
         DisplayUtil.removeForParent(this._maliang);
         DisplayUtil.removeForParent(this._alert);
         DisplayUtil.removeForParent(this._mc_6);
         DisplayUtil.removeForParent(this._mc_7);
         DisplayUtil.removeForParent(this._zhi);
      }
   }
}
