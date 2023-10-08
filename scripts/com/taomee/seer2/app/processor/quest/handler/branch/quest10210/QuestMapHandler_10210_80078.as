package com.taomee.seer2.app.processor.quest.handler.branch.quest10210
{
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10210_80078 extends QuestMapHandler
   {
       
      
      private var _mc2:MovieClip;
      
      public function QuestMapHandler_10210_80078(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(10210,1) && QuestManager.isStepComplete(10210,2) == false)
         {
            this.initQuest2();
         }
      }
      
      private function initQuest2() : void
      {
         this._mc2 = _processor.resLib.getMovieClip("mc2");
         this._mc2.buttonMode = true;
         _map.front.addChild(this._mc2);
         this._mc2.addEventListener(MouseEvent.CLICK,this.onMC2);
      }
      
      private function onMC2(param1:MouseEvent) : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.completeStep(10210,2);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         ServerMessager.addMessage("获得了材料A");
         SceneManager.changeScene(SceneType.COPY,80079);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         super.processMapDispose();
         if(this._mc2)
         {
            this._mc2.removeEventListener(MouseEvent.CLICK,this.onMC2);
            DisplayUtil.removeForParent(this._mc2);
         }
      }
   }
}
