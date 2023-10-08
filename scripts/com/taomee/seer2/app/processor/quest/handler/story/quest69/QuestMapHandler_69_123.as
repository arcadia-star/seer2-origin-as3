package com.taomee.seer2.app.processor.quest.handler.story.quest69
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_68;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.processor.quest.handler.story.quest68.QuestPlayMC;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_69_123 extends QuestMapHandler
   {
      
      private static var isOpen:Boolean;
       
      
      private var _mc1:MovieClip;
      
      public function QuestMapHandler_69_123(param1:QuestProcessor)
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
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,3) == false && QuestProcessor_68.questStatus == _quest.id)
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
                  if(SceneManager.prevSceneType == SceneType.ARENA)
                  {
                     return;
                  }
                  _mc1 = _processor.resLib.getMovieClip("mc1");
                  LayerManager.topLayer.addChild(_mc1);
                  MovieClipUtil.playMc(_mc1,1,_mc1.totalFrames,function():void
                  {
                     QuestPlayMC.playMC(_mc1,function():void
                     {
                     });
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
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         this.comQuest();
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"),"正在打开...");
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         isOpen = false;
         DisplayUtil.removeForParent(this._mc1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
   }
}
