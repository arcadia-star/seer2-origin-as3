package com.taomee.seer2.app.processor.quest.handler.main.quest7
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_7;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public class QuestMapHandler_7_Base extends QuestMapHandler
   {
       
      
      protected var _flagIndex:int;
      
      private var _animationStep4:MovieClip;
      
      private var _clickPet:MovieClip;
      
      private var _clickShaozi:SimpleButton;
      
      private var _sound:Sound;
      
      private var _soundChannel:SoundChannel;
      
      public function QuestMapHandler_7_Base(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,3) && !QuestManager.isStepComplete(_quest.id,4) && !QuestProcessor_7(_processor).isHaimaFound(this._flagIndex))
         {
            this.processStep4();
         }
      }
      
      private function processStep4() : void
      {
         this._animationStep4 = _map.content["quest_7"];
         MovieClipUtil.getChildList(this._animationStep4,2,["click"],function(param1:Vector.<DisplayObject>):void
         {
            _clickPet = param1[0] as MovieClip;
            _clickPet.buttonMode = true;
            _clickPet.addEventListener(MouseEvent.CLICK,onClickPet);
         });
      }
      
      private function onClickPet(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._clickPet.removeEventListener(MouseEvent.CLICK,this.onClickPet);
         this._clickPet.buttonMode = false;
         MovieClipUtil.getChildList(this._animationStep4,3,["shaozi"],function(param1:Vector.<DisplayObject>):void
         {
            _clickShaozi = param1[0] as SimpleButton;
            _clickShaozi.addEventListener(MouseEvent.CLICK,onClickShaozi);
         });
      }
      
      private function onClickShaozi(param1:MouseEvent) : void
      {
         this._clickShaozi.removeEventListener(MouseEvent.CLICK,this.onClickShaozi);
         this._animationStep4.gotoAndStop(1);
         QuestProcessor_7(_processor).setHaimaFlagServer(this._flagIndex);
         this._sound = _map.libManager.getSound("shaozi");
         this._soundChannel = this._sound.play();
         this.showSeerDialog();
      }
      
      protected function showSeerDialog() : void
      {
      }
      
      override public function processMapDispose() : void
      {
         if(this._clickPet)
         {
            this._clickPet.removeEventListener(MouseEvent.CLICK,this.onClickPet);
         }
         if(this._clickShaozi)
         {
            this._clickShaozi.removeEventListener(MouseEvent.CLICK,this.onClickShaozi);
         }
         if(this._soundChannel != null)
         {
            this._soundChannel.stop();
            this._soundChannel = null;
         }
      }
   }
}
