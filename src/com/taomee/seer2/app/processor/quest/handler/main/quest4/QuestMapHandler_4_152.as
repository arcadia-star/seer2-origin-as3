package com.taomee.seer2.app.processor.quest.handler.main.quest4
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_4_152 extends QuestMapHandler
   {
       
      
      private var _quest4FlowerHit:MovieClip;
      
      private var _quest4Flower:MovieClip;
      
      private var _frog:MovieClip;
      
      public function QuestMapHandler_4_152(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.isStepCompete(4))
         {
            if(!_quest.isStepCompete(5))
            {
               this.processStep5();
            }
            else if(!_quest.isStepCompete(6))
            {
               this.processStep6();
            }
         }
      }
      
      private function processStep5() : void
      {
         this._frog = _map.content["funnyFrog"];
         this._frog.addEventListener(Event.ENTER_FRAME,this.onFrogEnterFrame);
         var _loc1_:MovieClip = _map.content["ghostFlower"];
         this._quest4FlowerHit = _map.content["quest4FlowerHit"];
         this._quest4FlowerHit.addEventListener(MouseEvent.CLICK,this.onQuest4FlowerHitClick);
         DisplayObjectUtil.disableButtonMode(this._quest4FlowerHit);
         this._quest4Flower = _loc1_["quest4Flower"];
         _processor.showMouseHintAt(390,380);
      }
      
      private function onQuest4FlowerHitClick(param1:MouseEvent) : void
      {
         _processor.hideMouseClickHint();
         DisplayObjectUtil.disableButtonMode(this._quest4FlowerHit);
         this._quest4Flower.addEventListener(Event.ENTER_FRAME,this.onquest4FlowerEnterFrame);
         this._quest4Flower.gotoAndPlay(1);
      }
      
      private function onquest4FlowerEnterFrame(param1:Event) : void
      {
         var message:String = null;
         var evt:Event = param1;
         if(this._quest4Flower.currentFrame == this._quest4Flower.totalFrames)
         {
            this._quest4Flower.removeEventListener(Event.ENTER_FRAME,this.onquest4FlowerEnterFrame);
            this._quest4Flower.stop();
            message = "你已收集蔓藤花粉";
            ServerMessager.addMessage(message);
            DialogPanel.showForSimple(400,"我",[[0,"哈！搞定！现在就去和特鲁伊会合吧！"]],"去草系主城……",function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep5);
               QuestManager.completeStep(_quest.id,5);
            });
         }
      }
      
      private function onCompleteStep5(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep5);
            this.processStep6();
         }
      }
      
      private function onFrogEnterFrame(param1:Event) : void
      {
         if(this._frog.currentFrame == 2)
         {
            _processor.hideMouseClickHint();
         }
         if(this._frog.currentFrame == 6)
         {
            DisplayObjectUtil.enableButtonMode(this._quest4FlowerHit);
            _processor.showMouseHintAt(440,260);
            this._frog.removeEventListener(Event.ENTER_FRAME,this.onFrogEnterFrame);
         }
      }
      
      private function processStep6() : void
      {
         _processor.showMouseHintAt(60,310);
      }
   }
}
