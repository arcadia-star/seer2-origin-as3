package com.taomee.seer2.app.processor.quest.handler.story.quest69
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_68;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.ResContentLibrary;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_69_90 extends QuestMapHandler
   {
      
      private static var isOpen:Boolean;
       
      
      private var _mc3:MovieClip;
      
      public function QuestMapHandler_69_90(param1:QuestProcessor)
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
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,2) == false && QuestProcessor_68.questStatus == _quest.id)
         {
            isOpen = true;
            ActiveCountManager.requestActiveCount(203857,function(param1:uint, param2:uint):void
            {
               var type:uint = param1;
               var count:uint = param2;
               if(count == 1)
               {
                  comQuest();
               }
               else
               {
                  _mc3 = _processor.resLib.getMovieClip("mc3");
                  LayerManager.topLayer.addChild(_mc3);
                  ResContentLibrary.setScaleValue(_mc3);
                  MovieClipUtil.playMc(_mc3,1,_mc3.totalFrames,function():void
                  {
                     DisplayUtil.removeForParent(_mc3);
                     ModuleManager.toggleModule(URLUtil.getAppModule("MapSignPanel"),"正在打开...",{"categoryId":2});
                  },true);
               }
            });
         }
      }
      
      private function comQuest() : void
      {
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.completeStep(69,_quest.getCurrentOrNextStep().id);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"),"正在打开...");
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         this.comQuest();
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         isOpen = false;
         DisplayUtil.removeForParent(this._mc3);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
   }
}
