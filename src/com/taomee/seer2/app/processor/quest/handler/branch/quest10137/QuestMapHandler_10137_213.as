package com.taomee.seer2.app.processor.quest.handler.branch.quest10137
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10137_213 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_10137_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,4) && QuestManager.isStepComplete(_quest.id,5) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "10137_1")
         {
            _processor.showMouseHintAt(240,349);
            this._mc_0 = _processor.resLib.getMovieClip("guai");
            _map.content.addChild(this._mc_0);
            this._mc_0.buttonMode = true;
            this._mc_0.addEventListener(MouseEvent.CLICK,this.onClickGuaiHandler);
         }
      }
      
      private function onClickGuaiHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         _processor.hideMouseClickHint();
         NpcDialog.show(27,"占卜婆婆",[[0,"这个……这个就送给你啦！它可是具有魔法的哦！它可以帮助任何生物复明！"]],["咦！这好像和另外个愿望有关！"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"好嘞！我这就去给安德送上色彩！"]],[" 前往深幽沼泽"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep5Handler);
               QuestManager.completeStep(_quest.id,5);
            }]);
         }]);
      }
      
      private function onStep5Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep5Handler);
         SceneManager.changeScene(SceneType.LOBBY,133);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep5Handler);
      }
   }
}
