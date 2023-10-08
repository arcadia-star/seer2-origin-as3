package com.taomee.seer2.app.processor.quest.handler.branch.quest10215
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10215_133 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      public function QuestMapHandler_10215_133(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10215) && QuestManager.isStepComplete(10215,1) == false)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"这……这是哪？我还在做梦吗？"]],["谁！谁站在那里！"],[function():void
         {
            _mc1 = _processor.resLib.getMovieClip("mc1");
            _map.front.addChild(_mc1);
            MovieClipUtil.playMc(_mc1,2,_mc1.totalFrames,function():void
            {
               _mc2 = _processor.resLib.getMovieClip("mc2");
               _map.front.addChild(_mc2);
               MovieClipUtil.playMc(_mc2,2,_mc2.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_mc2);
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10215_1"),function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                     QuestManager.completeStep(10215,1);
                  },true);
               },true);
            },true);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.COPY,80102);
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mc2);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
   }
}
