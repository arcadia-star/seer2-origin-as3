package com.taomee.seer2.app.processor.quest.handler.branch.quest10004
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10004_133 extends QuestMapHandler
   {
       
      
      private var _fluorescence:SimpleButton;
      
      private var _mc:MovieClip;
      
      public function QuestMapHandler_10004_133(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(QuestManager.isStepComplete(10004,4) && !QuestManager.isStepComplete(10004,5))
         {
            this.addFluorescence();
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10004 && QuestManager.isStepComplete(10004,4) && !QuestManager.isStepComplete(10004,5))
         {
            this.addFluorescence();
         }
      }
      
      private function addFluorescence() : void
      {
         this._fluorescence = _processor.resLib.getButton("mc_2");
         _map.content.addChild(this._fluorescence);
         this._fluorescence.addEventListener(MouseEvent.CLICK,this.onFluorescence);
      }
      
      private function onFluorescence(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._mc = _processor.resLib.getMovieClip("mc_3");
         LayerManager.topLayer.addChild(this._mc);
         MovieClipUtil.playMc(this._mc,1,this._mc.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(_mc);
            _mc = null;
            DisplayObjectUtil.removeFromParent(_fluorescence);
            QuestManager.completeStep(_quest.id,5);
            DialogPanel.showForSimple(10,"巴蒂",[[0,"太棒了！按照博士说的，合体容器这样就可以了。晓晓、月月一定等不及了！"]],"嗯，我们现在就拿给它们！",function():void
            {
               ServerMessager.addMessage("去夜晚的荆棘小道找兔子晓晓吧！");
            });
         });
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(this._fluorescence)
         {
            this._fluorescence.removeEventListener(MouseEvent.CLICK,this.onFluorescence);
            this._fluorescence = null;
            _map = null;
         }
      }
   }
}
