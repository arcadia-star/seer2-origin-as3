package com.taomee.seer2.app.processor.quest.handler.main.quest8
{
   import com.greensock.TweenLite;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class QuestMapHandler_8_204 extends QuestMapHandler
   {
      
      private static const PET_POSITION_ARR:Array = [[239,362],[350,284],[414.5,219]];
       
      
      private var _haimaPet:MovieClip;
      
      private var _rockBtn:SimpleButton;
      
      private var _ropeBtn:SimpleButton;
      
      private var _rockDownAnimation:MovieClip;
      
      private var _untrapPetAnimation:MovieClip;
      
      private var _trapPetAnimation:MovieClip;
      
      private var _walkPetAnimation:MovieClip;
      
      private var _pullPet:MovieClip;
      
      private var _pullPetAnimation:MovieClip;
      
      private var _pullPetClick1:MovieClip;
      
      private var _pullPetClick2:MovieClip;
      
      private var _teleport:Teleport;
      
      private var _positionIndex:int;
      
      private var _hasRockDown:Boolean = false;
      
      private var _clickAreaCount:int;
      
      private var _pullTimer:Timer;
      
      public function QuestMapHandler_8_204(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(Boolean(_quest.isStepCompete(4)) && !_quest.isStepCompete(5))
         {
            this.extractAssets();
         }
      }
      
      private function extractAssets() : void
      {
         var container:MovieClip;
         super.processMapComplete();
         container = _map.content["quest_8"];
         DisplayObjectUtil.removeFromParent(container);
         MovieClipUtil.getChildList(container,2,["haima","rock","rope","rockDown","untrapPet","trapPet","walkPet","pullPet"],function(param1:Vector.<DisplayObject>):void
         {
            _haimaPet = param1[0] as MovieClip;
            _rockBtn = param1[1] as SimpleButton;
            _ropeBtn = param1[2] as SimpleButton;
            _rockDownAnimation = param1[3] as MovieClip;
            _untrapPetAnimation = param1[4] as MovieClip;
            _trapPetAnimation = param1[5] as MovieClip;
            _walkPetAnimation = param1[6] as MovieClip;
            _pullPet = param1[7] as MovieClip;
            _pullPetAnimation = _pullPet["animation"];
            _pullPetClick1 = _pullPet["click1"];
            _pullPetClick2 = _pullPet["click2"];
            _teleport = AnimateElementManager.getElement(1) as Teleport;
            processStep5();
         });
      }
      
      private function processStep5() : void
      {
         this._positionIndex = 0;
         this._haimaPet.x = PET_POSITION_ARR[0][0];
         this._haimaPet.y = PET_POSITION_ARR[0][1];
         _map.content.addChild(this._haimaPet);
         _processor.showMouseHintOver(this._haimaPet);
         DisplayObjectUtil.enableButtonMode(this._haimaPet);
         this._haimaPet.addEventListener(MouseEvent.CLICK,this.onClickHaima1);
      }
      
      private function onClickHaima1(param1:MouseEvent) : void
      {
         _processor.hideMouseClickHint();
         DisplayObjectUtil.disableButtonMode(this._haimaPet);
         this.walkHaima();
      }
      
      private function walkHaima() : void
      {
         ++this._positionIndex;
         TweenLite.to(this._haimaPet,1,{
            "x":PET_POSITION_ARR[this._positionIndex][0],
            "y":PET_POSITION_ARR[this._positionIndex][1],
            "onComplete":function():void
            {
               if(_positionIndex != 2)
               {
                  _processor.showMouseHintOver(_haimaPet);
                  DisplayObjectUtil.enableButtonMode(_haimaPet);
               }
               else
               {
                  _map.content.addChild(_rockBtn);
                  _map.content.addChild(_ropeBtn);
                  _map.content.addChild(_rockDownAnimation);
                  _map.content.addChild(_untrapPetAnimation);
                  _map.content.addChild(_trapPetAnimation);
                  _map.content.addChild(_walkPetAnimation);
                  _haimaPet.removeEventListener(MouseEvent.CLICK,onClickHaima1);
                  _haimaPet.addEventListener(MouseEvent.CLICK,onClickHaima2);
                  _rockBtn.addEventListener(MouseEvent.CLICK,onClickRockBtn);
                  _ropeBtn.addEventListener(MouseEvent.CLICK,onClickRopeBtn);
                  _rockBtn.visible = false;
                  _ropeBtn.visible = false;
                  DisplayObjectUtil.enableButtonMode(_haimaPet);
               }
            }
         });
      }
      
      private function onClickHaima2(param1:MouseEvent) : void
      {
         if(!this._hasRockDown)
         {
            this._rockBtn.visible = true;
         }
         this._ropeBtn.visible = true;
         DisplayObjectUtil.disableButtonMode(this._haimaPet);
      }
      
      private function onClickRockBtn(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._rockBtn.visible = false;
         this._ropeBtn.visible = false;
         MovieClipUtil.playMc(this._rockDownAnimation,2,this._rockDownAnimation.totalFrames,function():void
         {
            _hasRockDown = true;
            DisplayObjectUtil.enableButtonMode(_haimaPet);
            _teleport.visible = false;
         });
      }
      
      private function onClickRopeBtn(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._rockBtn.visible = false;
         this._ropeBtn.visible = false;
         if(this._hasRockDown)
         {
            LayerManager.focusOnUILayer();
            LayerManager.topLayer.addChild(this._pullPet);
            DisplayObjectUtil.enableButtonMode(this._pullPetClick1);
            DisplayObjectUtil.enableButtonMode(this._pullPetClick2);
            this._pullPetClick1.addEventListener(MouseEvent.CLICK,this.onClickPullPet);
            this._pullPetClick2.addEventListener(MouseEvent.CLICK,this.onClickPullPet);
            this._clickAreaCount = 0;
            if(this._pullTimer == null)
            {
               this._pullTimer = new Timer(5000);
               this._pullTimer.addEventListener(TimerEvent.TIMER,this.onPullTimer);
            }
            this._pullTimer.start();
         }
         else
         {
            MovieClipUtil.playMc(this._untrapPetAnimation,2,this._untrapPetAnimation.totalFrames,function():void
            {
               _untrapPetAnimation.gotoAndStop(1);
               DisplayObjectUtil.enableButtonMode(_haimaPet);
            },true);
         }
      }
      
      private function onClickPullPet(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ++this._clickAreaCount;
         MovieClipUtil.playMc(this._pullPetAnimation,"startPull","endPull");
         if(this._clickAreaCount >= 10)
         {
            this._pullTimer.stop();
            DisplayObjectUtil.removeFromParent(this._pullPet);
            LayerManager.resetOperation();
            DialogPanel.showForSimple(11,"多罗",[[2,"没事了……没事了！一切都会好的！队长，我们怎么办？"]],"（大块头兄弟可能有办法救它）",function():void
            {
               DialogPanel.showForSimple(NpcUtil.getSeerNpcId(),"我",[[0,"快……事不宜迟！只有找到当地族民才能解决"]],"（快跟着我！）",function():void
               {
                  MovieClipUtil.playMc(_trapPetAnimation,2,_trapPetAnimation.totalFrames,function():void
                  {
                     _teleport.visible = true;
                     DisplayObjectUtil.removeFromParent(_rockDownAnimation);
                     DisplayObjectUtil.removeFromParent(_haimaPet);
                     DisplayObjectUtil.removeFromParent(_trapPetAnimation);
                     MovieClipUtil.playMc(_walkPetAnimation,2,_walkPetAnimation.totalFrames,function():void
                     {
                        QuestManager.completeStep(_quest.id,5);
                     },true);
                  },true);
               });
            });
         }
      }
      
      private function onPullTimer(param1:TimerEvent) : void
      {
         var evt:TimerEvent = param1;
         this._pullTimer.stop();
         if(this._clickAreaCount < 10)
         {
            MovieClipUtil.playMc(this._pullPetAnimation,"startEsc","endEsc",function():void
            {
               DisplayObjectUtil.removeFromParent(_pullPet);
               LayerManager.resetOperation();
               DisplayObjectUtil.enableButtonMode(_haimaPet);
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._haimaPet != null)
         {
            TweenLite.killTweensOf(this._haimaPet,true);
            this._haimaPet.removeEventListener(MouseEvent.CLICK,this.onClickHaima1);
            this._haimaPet.removeEventListener(MouseEvent.CLICK,this.onClickHaima2);
            this._rockBtn.removeEventListener(MouseEvent.CLICK,this.onClickRockBtn);
            this._ropeBtn.removeEventListener(MouseEvent.CLICK,this.onClickRopeBtn);
            this._pullPetClick1.removeEventListener(MouseEvent.CLICK,this.onClickPullPet);
            this._pullPetClick2.removeEventListener(MouseEvent.CLICK,this.onClickPullPet);
         }
         if(this._pullTimer != null)
         {
            this._pullTimer.stop();
            this._pullTimer.removeEventListener(TimerEvent.TIMER,this.onPullTimer);
         }
      }
   }
}
