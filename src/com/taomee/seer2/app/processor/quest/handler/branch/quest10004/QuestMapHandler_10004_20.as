package com.taomee.seer2.app.processor.quest.handler.branch.quest10004
{
   import com.taomee.seer2.app.animationInteractive.AnimationEvent;
   import com.taomee.seer2.app.animationInteractive.PuzzlePictureAnimation;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10004_20 extends QuestMapHandler
   {
       
      
      private var _puzzleBtn:SimpleButton;
      
      private var _puzzlePicture:PuzzlePictureAnimation;
      
      public function QuestMapHandler_10004_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepQuest);
         this._puzzlePicture = new PuzzlePictureAnimation();
         if(QuestManager.isStepComplete(10004,3) && !QuestManager.isStepComplete(10004,4))
         {
            this.createPuzzleBtn();
         }
      }
      
      private function onStepQuest(param1:QuestEvent) : void
      {
         if(param1.questId == 10004)
         {
            if(QuestManager.isStepComplete(10004,3) && !QuestManager.isStepComplete(10004,4))
            {
               this.createPuzzleBtn();
               ServerMessager.addMessage("将博士身边的容器摆好后再找博士。");
            }
            else if(QuestManager.isStepComplete(10004,4) && !QuestManager.isStepComplete(10004,5))
            {
               ServerMessager.addMessage("获得了神秘的容器");
               DisplayObjectUtil.removeFromParent(this._puzzleBtn);
               DialogPanel.showForSimple(2,"伊娃博士",[[0,"摆好了？聪明的小家伙！听好，把容器拿到深幽沼泽，敲那棵发光的大树，收集它的荧光，然后交给你的兔子朋友。再见！"]],"我记住了，谢谢博士！再见！",this.onCloseDialog);
            }
         }
      }
      
      private function onCloseDialog() : void
      {
         ServerMessager.addMessage("到深幽沼泽点发光的大树！");
      }
      
      private function createPuzzleBtn() : void
      {
         this._puzzleBtn = _processor.resLib.getButton("mc_1");
         _map.content.addChild(this._puzzleBtn);
         if(QuestManager.isStepComplete(10004,3) && !QuestManager.isStepComplete(10004,4))
         {
            this.addPuzzleListener();
         }
      }
      
      private function addPuzzleListener() : void
      {
         this._puzzleBtn.addEventListener(MouseEvent.CLICK,this.onPuzzlePicture);
      }
      
      private function closePuzzleListener() : void
      {
         this._puzzleBtn.removeEventListener(MouseEvent.CLICK,this.onPuzzlePicture);
      }
      
      private function onPuzzlePicture(param1:MouseEvent) : void
      {
         this._puzzlePicture.setup("puzzlePicture");
         this._puzzlePicture.addEventListener(AnimationEvent.PUZZLEPICTURE,this.onPuzzleOver);
         this._puzzlePicture.addEventListener(Event.CLOSE,this.onCloseAnimation);
      }
      
      private function onPuzzleOver(param1:Event) : void
      {
         QuestManager.completeStep(_quest.id,4);
      }
      
      private function onCloseAnimation(param1:Event) : void
      {
         this._puzzlePicture.removeEventListener(AnimationEvent.PUZZLEPICTURE,this.onPuzzleOver);
         this._puzzlePicture.removeEventListener(Event.CLOSE,this.onCloseAnimation);
         if(QuestManager.isStepComplete(10004,4))
         {
            this.closePuzzleListener();
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepQuest);
         if(this._puzzlePicture)
         {
            this._puzzlePicture.removeEventListener(Event.CLOSE,this.onCloseAnimation);
            this._puzzlePicture = null;
         }
         if(this._puzzleBtn)
         {
            this.closePuzzleListener();
            this._puzzleBtn = null;
         }
      }
   }
}
