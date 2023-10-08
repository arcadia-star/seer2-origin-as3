package com.taomee.seer2.app.processor.quest.handler.main.quest6
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_6_121 extends QuestMapHandler
   {
       
      
      private var _stepAnimation_4_0:MovieClip;
      
      private var _clickDuoluo:MovieClip;
      
      private var _clickBadi:MovieClip;
      
      private var _stepAnimation_4_1:MovieClip;
      
      private var _clickBtn1:SimpleButton;
      
      private var _clickBtn2:SimpleButton;
      
      private var _stepAnimation_4_2:MovieClip;
      
      public function QuestMapHandler_6_121(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(4))
         {
            this.processStep4();
         }
      }
      
      private function extractAssets() : void
      {
         this._stepAnimation_4_0 = _map.content["quest_6_4_0"];
         this._stepAnimation_4_1 = _map.content["quest_6_4_1"];
         this._stepAnimation_4_1.gotoAndStop(2);
         this._stepAnimation_4_2 = _map.front["quest_6_4_2"];
      }
      
      private function processStep4() : void
      {
         this.extractAssets();
         MovieClipUtil.playMc(this._stepAnimation_4_0,2,this._stepAnimation_4_0.totalFrames,function():void
         {
            MovieClipUtil.getChildList(_stepAnimation_4_0,_stepAnimation_4_0.totalFrames,["duoluo","badi"],function(param1:Vector.<DisplayObject>):void
            {
               _clickDuoluo = param1[0] as MovieClip;
               _clickBadi = param1[1] as MovieClip;
               _clickBadi.buttonMode = true;
               _clickDuoluo.buttonMode = true;
               _clickDuoluo.addEventListener(MouseEvent.CLICK,onClickDuoluo1);
               _processor.showMouseHintAt(915,457);
            });
         },true);
      }
      
      private function onClickDuoluo1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         _processor.hideMouseClickHint();
         this._clickDuoluo.removeEventListener(MouseEvent.CLICK,this.onClickDuoluo1);
         DialogPanel.showForSimple(11,"多罗",[[4,"明明看到它跑到这里来的啊……没理由啊……"]],"咦？？那个某某某神兽内？",function():void
         {
            DialogPanel.showForSimple(10,"巴蒂",[[3,"笨蛋啊！它肯定就在附近啊！找啊！"]],"（四处找找）",function():void
            {
               _clickBadi.addEventListener(MouseEvent.CLICK,onClickBadi);
               _clickDuoluo.addEventListener(MouseEvent.CLICK,onClickDuoluo2);
               _stepAnimation_4_1.buttonMode = true;
               _stepAnimation_4_1.addEventListener(MouseEvent.CLICK,onClickStepAnimation_4_1);
            });
         });
      }
      
      private function onClickBadi(param1:MouseEvent) : void
      {
         DialogPanel.showForSimple(10,"巴蒂",[[0,"到底会在哪里呢？咦？队长！这里似乎多了一个蘑菇？"]],"（蘑菇？）");
      }
      
      private function onClickDuoluo2(param1:MouseEvent) : void
      {
         DialogPanel.showForSimple(11,"多罗",[[4,"第七小分队的明天就看你的啦！队长你一定找的到的哦？"]],"（好大的压力……）");
      }
      
      private function onClickStepAnimation_4_1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._clickBadi.removeEventListener(MouseEvent.CLICK,this.onClickBadi);
         this._clickDuoluo.removeEventListener(MouseEvent.CLICK,this.onClickDuoluo2);
         this._stepAnimation_4_1.buttonMode = false;
         this._stepAnimation_4_1.removeEventListener(MouseEvent.CLICK,this.onClickStepAnimation_4_1);
         MovieClipUtil.playMc(this._stepAnimation_4_1,"startShow","endShow",function():void
         {
            MovieClipUtil.getChildList(_stepAnimation_4_1,"endShow",["btn_1","btn_2"],function(param1:Vector.<DisplayObject>):void
            {
               _clickBtn1 = param1[0] as SimpleButton;
               _clickBtn2 = param1[1] as SimpleButton;
               _clickBtn1.addEventListener(MouseEvent.CLICK,onClickBtn1);
               _clickBtn2.addEventListener(MouseEvent.CLICK,onClickBtn2);
            });
         },true);
      }
      
      private function onClickBtn1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this.clearClickBtn();
         MovieClipUtil.playMc(this._stepAnimation_4_1,"startBtn1","endBtn1",function():void
         {
            _stepAnimation_4_1.gotoAndStop(2);
            _stepAnimation_4_1.buttonMode = true;
            _stepAnimation_4_1.addEventListener(MouseEvent.CLICK,onClickStepAnimation_4_1);
         },true);
      }
      
      private function onClickBtn2(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this.clearClickBtn();
         MovieClipUtil.playMc(this._stepAnimation_4_1,"startBtn2","endBtn2",function():void
         {
            _stepAnimation_4_0.gotoAndStop(1);
            _stepAnimation_4_1.gotoAndStop(1);
            DisplayObjectUtil.removeFromParent(_stepAnimation_4_0);
            DisplayObjectUtil.removeFromParent(_stepAnimation_4_1);
            MovieClipUtil.playMc(_stepAnimation_4_2,2,_stepAnimation_4_2.totalFrames,function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete4);
               QuestManager.completeStep(_quest.id,4);
            },true);
         },true);
      }
      
      private function onStepComplete4(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete4);
            _processor.showMouseHintAt(400,260);
         }
      }
      
      private function clearClickBtn() : void
      {
         this._clickBtn1.removeEventListener(MouseEvent.CLICK,this.onClickBtn1);
         this._clickBtn2.removeEventListener(MouseEvent.CLICK,this.onClickBtn2);
         this._clickBtn1 = null;
         this._clickBtn2 = null;
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._clickDuoluo)
         {
            this._clickDuoluo.removeEventListener(MouseEvent.CLICK,this.onClickDuoluo1);
            this._clickDuoluo.removeEventListener(MouseEvent.CLICK,this.onClickDuoluo2);
            this._clickBadi.removeEventListener(MouseEvent.CLICK,this.onClickBadi);
            this._stepAnimation_4_1.removeEventListener(MouseEvent.CLICK,this.onClickStepAnimation_4_1);
         }
         if(this._clickBtn1)
         {
            this._clickBtn1.removeEventListener(MouseEvent.CLICK,this.onClickBtn1);
            this._clickBtn2.removeEventListener(MouseEvent.CLICK,this.onClickBtn2);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete4);
      }
   }
}
