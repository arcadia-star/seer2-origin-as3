package com.taomee.seer2.app.processor.quest.handler.main.quest6
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_6_90 extends QuestMapHandler
   {
       
      
      private var _animationStep2:MovieClip;
      
      private var _clickStep2:MovieClip;
      
      private var _animationStep3:MovieClip;
      
      private var _clickStep3:MovieClip;
      
      private var _animationStep3_1:MovieClip;
      
      private var _animationStep3_2:MovieClip;
      
      public function QuestMapHandler_6_90(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this.extractAssets();
         if(_quest.isStepCompete(1))
         {
            if(!_quest.isStepCompete(2))
            {
               this.processStep2();
            }
            else if(!_quest.isStepCompete(3))
            {
               this.processStep3();
            }
         }
      }
      
      private function extractAssets() : void
      {
         this._animationStep2 = _map.content["quest_6_2"];
         this._animationStep3 = _map.content["quest_6_3"];
         this._animationStep3_1 = _map.content["quest_6_3_1"];
         this._animationStep3_2 = _map.content["quest_6_3_2"];
      }
      
      private function processStep2() : void
      {
         MovieClipUtil.playMc(this._animationStep2,2,this._animationStep2.totalFrames,function():void
         {
            MovieClipUtil.getChildList(_animationStep2,_animationStep2.totalFrames,["duoluo"],function(param1:Vector.<DisplayObject>):void
            {
               _processor.showMouseHintAt(430,220);
               _clickStep2 = param1[0] as MovieClip;
               _clickStep2.buttonMode = true;
               _clickStep2.addEventListener(MouseEvent.CLICK,onClickStep2);
            });
         },true);
      }
      
      private function onClickStep2(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._clickStep2.buttonMode = false;
         this._clickStep2.removeEventListener(MouseEvent.CLICK,this.onClickStep2);
         _processor.hideMouseClickHint();
         DialogPanel.showForSimple(11,"多罗",[[0,"队……队长！我做了一个很奇怪的梦！"]],"额？梦？",function():void
         {
            DialogPanel.showForSimple(10,"巴蒂",[[0,"一个梦就大惊小怪……没见过世面！不过……我似乎也做了一个奇怪的梦……"]],"其实我也有梦到啊",function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("6/quest6Animation1"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete2);
                  QuestManager.completeStep(_quest.id,2);
               });
            });
         });
      }
      
      private function onStepComplete2(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete2);
            this.processStep3();
         }
      }
      
      private function processStep3() : void
      {
         this._animationStep2.gotoAndStop(this._animationStep2.totalFrames);
         DialogPanel.showForSimple(11,"多罗",[[2,"啊……啊……啊……不是这么巧吧！！！我梦到的就是这样……我怕……"]],"肯定有蹊跷！",function():void
         {
            DialogPanel.showForSimple(10,"巴蒂",[[4,"队长……这一定不是巧合！我也做了同样的梦！"]],"谁？是谁？",function():void
            {
               MovieClipUtil.playMc(_animationStep3,2,_animationStep3.totalFrames,function():void
               {
                  MovieClipUtil.getChildList(_animationStep3,_animationStep3.totalFrames,["jss"],function(param1:Vector.<DisplayObject>):void
                  {
                     _processor.showMouseHintAt(300,270);
                     _clickStep3 = param1[0] as MovieClip;
                     _clickStep3.buttonMode = true;
                     _clickStep3.addEventListener(MouseEvent.CLICK,onClickStep3);
                  });
               },true);
            });
         });
      }
      
      private function onClickStep3(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         _processor.hideMouseClickHint();
         this._clickStep3.buttonMode = false;
         this._clickStep3.removeEventListener(MouseEvent.CLICK,this.onClickStep3);
         AlertManager.showFakeDogzAlert(function():void
         {
            _animationStep3.gotoAndStop(1);
            MovieClipUtil.playMc(_animationStep3_1,2,_animationStep3_1.totalFrames,function():void
            {
               _animationStep2.gotoAndStop(1);
               MovieClipUtil.playMc(_animationStep3_2,2,_animationStep3_2.totalFrames,function():void
               {
                  DialogPanel.showForSimple(NpcUtil.getSeerNpcId(),"我",[[0,"这不是通往异蘑世界的入口嘛！……等等！"]],"（巴蒂和多罗已经走远）",function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete3);
                     QuestManager.completeStep(_quest.id,3);
                  });
               },true);
            },true);
         });
      }
      
      private function onStepComplete3(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete3);
            _processor.showMouseHintAt(600,485);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete2);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete3);
         if(this._clickStep2)
         {
            this._clickStep2.removeEventListener(MouseEvent.CLICK,this.onClickStep2);
         }
         if(this._clickStep3)
         {
            this._clickStep3.removeEventListener(MouseEvent.CLICK,this.onClickStep3);
         }
      }
   }
}
