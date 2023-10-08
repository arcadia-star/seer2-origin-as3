package com.taomee.seer2.app.processor.quest.handler.story.quest63
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_63_20 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_63_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.addPeople();
         }
      }
      
      private function addPeople() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc1");
         _map.content.addChild(this._mc_0);
         var _loc1_:MovieClip = this._mc_0["ma"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClickTalkHandler);
      }
      
      private function onClickTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._mc_1 = _processor.resLib.getMovieClip("talk");
         LayerManager.topLayer.addChild(this._mc_1);
         MovieClipUtil.playMc(this._mc_1,1,this._mc_1.totalFrames,function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Complete);
            QuestManager.completeStep(_quest.id,1);
         },true);
      }
      
      private function onStep1Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         SceneManager.changeScene(SceneType.LOBBY,10106);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
      }
   }
}
