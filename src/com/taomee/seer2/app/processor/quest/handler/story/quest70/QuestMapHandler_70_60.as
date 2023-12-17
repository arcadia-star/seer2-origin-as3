package com.taomee.seer2.app.processor.quest.handler.story.quest70
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_68;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.processor.quest.handler.story.quest68.QuestPlayMC;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.ResContentLibrary;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_70_60 extends QuestMapHandler
   {
      
      private static var isOpen:Boolean;
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      public function QuestMapHandler_70_60(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isOpen)
         {
            return;
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false && QuestProcessor_68.questStatus == _quest.id)
         {
            isOpen = true;
            this._mc1 = _processor.resLib.getMovieClip("mc1");
            LayerManager.topLayer.addChild(this._mc1);
            MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
            {
               QuestPlayMC.playMC(_mc1,function():void
               {
                  DisplayUtil.removeForParent(_mc1);
                  _mc2 = _processor.resLib.getMovieClip("mc2");
                  LayerManager.topLayer.addChild(_mc2);
                  ResContentLibrary.setScaleValue(_mc2);
                  playMC2();
               });
            },true);
         }
      }
      
      private function playMC2() : void
      {
         MovieClipUtil.playMc(this._mc2,2,this._mc2.totalFrames,function():void
         {
            _mc2["next"].addEventListener(MouseEvent.CLICK,onNext);
            _mc2["com"].addEventListener(MouseEvent.CLICK,onCom);
         },true);
      }
      
      private function onNext(param1:MouseEvent) : void
      {
         this._mc2["next"].removeEventListener(MouseEvent.CLICK,this.onNext);
         this._mc2["com"].removeEventListener(MouseEvent.CLICK,this.onCom);
         this.playMC2();
      }
      
      private function onCom(param1:MouseEvent) : void
      {
         this._mc2["next"].removeEventListener(MouseEvent.CLICK,this.onNext);
         this._mc2["com"].removeEventListener(MouseEvent.CLICK,this.onCom);
         DisplayUtil.removeForParent(this._mc2);
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.completeStep(70,1);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"),"正在打开...");
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         isOpen = false;
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mc2);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
   }
}
