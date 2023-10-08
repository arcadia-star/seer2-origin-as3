package com.taomee.seer2.app.processor.quest.handler.main.quest7
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_7;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_7_151 extends QuestMapHandler
   {
       
      
      private var _hemaMc:MovieClip;
      
      private var _stepAnimation0:MovieClip;
      
      private var _clickKu:MovieClip;
      
      private var _clickNaiZui:MovieClip;
      
      private var _stepAnimation1:MovieClip;
      
      public function QuestMapHandler_7_151(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this.extractAssets();
         if(_quest.status == QuestStatus.ACCEPTABLE)
         {
            _map.content.addChild(this._hemaMc);
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         }
         else if(_quest.status == QuestStatus.IN_PROGRESS)
         {
            if(!_quest.isStepCompete(1))
            {
               this.processStep1();
            }
            else if(!_quest.isStepCompete(2))
            {
               this.processStep2();
            }
            else if(!_quest.isStepCompete(3))
            {
               this.processStep3();
            }
            else if(!_quest.isStepCompete(4))
            {
               this.processStep4();
            }
            else if(!_quest.isStepCompete(5))
            {
               this.processStep5();
            }
         }
      }
      
      private function extractAssets() : void
      {
         this._stepAnimation0 = _map.content["quest_7_0"];
         this._stepAnimation1 = _map.content["quest_7_1"];
         this._hemaMc = _map.libManager.getMovieClip("hema");
         this._hemaMc.x = 301;
         this._hemaMc.y = 255;
      }
      
      private function onQuestAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
            this.processStep1();
         }
      }
      
      private function processStep1() : void
      {
         _map.content.addChild(this._hemaMc);
         MovieClipUtil.playNpcTalk(URLUtil.getQuestNpcTalkAnimation("7_0"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep1);
            QuestManager.completeStep(_quest.id,1);
         });
      }
      
      private function onCompleteStep1(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            this.processStep2();
         }
      }
      
      private function processStep2() : void
      {
         DisplayObjectUtil.removeFromParent(this._hemaMc);
         MovieClipUtil.getChildList(this._stepAnimation0,2,["click"],function(param1:Vector.<DisplayObject>):void
         {
            _clickKu = param1[0] as MovieClip;
            _clickKu.buttonMode = true;
            _processor.showMouseHintOver(_clickKu);
            _clickKu.addEventListener(MouseEvent.CLICK,onClickKu);
         });
      }
      
      private function onClickKu(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         _processor.hideMouseClickHint();
         this._clickKu.removeEventListener(MouseEvent.CLICK,this.onClickKu);
         MovieClipUtil.getChildList(this._stepAnimation0,3,["click"],function(param1:Vector.<DisplayObject>):void
         {
            _clickNaiZui = param1[0] as MovieClip;
            _clickNaiZui.buttonMode = true;
            _clickNaiZui.addEventListener(MouseEvent.CLICK,onNaiZuiClick);
         });
      }
      
      private function onNaiZuiClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._clickNaiZui.removeEventListener(MouseEvent.CLICK,this.onNaiZuiClick);
         MovieClipUtil.playMc(this._stepAnimation0,4,this._stepAnimation0.totalFrames,function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep2);
            QuestManager.completeStep(_quest.id,2);
         },true);
      }
      
      private function onCompleteStep2(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep2);
            this.processStep3();
         }
      }
      
      private function processStep3() : void
      {
         DisplayObjectUtil.removeFromParent(this._stepAnimation0);
         _map.content.addChild(this._hemaMc);
         DialogPanel.showForSimple(11,"多罗",[[0,"大队长！我们帮小海马找到失落的那5个伙伴吧？我好喜欢它……"]],"可是我们要怎么找呢……",function():void
         {
            DialogPanel.showForSimple(11,"多罗",[[0,"小海马给我们一个哨子，只要你找到它们吹这个哨子，小海马就会跟着你走咯！"]],"哨子？不管了，在草目氏族找找吧……",function():void
            {
               DialogPanel.showForSimple(11,"多罗",[[4,"我在这里掩护小海马！老大……嘿嘿……你加油！不送啦……"]],"你这家伙！明摆着偷懒……好吧！",function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep3);
                  QuestManager.completeStep(_quest.id,3);
               });
            });
         });
      }
      
      private function onCompleteStep3(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep3);
            this.processStep4();
         }
      }
      
      private function processStep4() : void
      {
         _map.content.addChild(this._hemaMc);
      }
      
      private function processStep5() : void
      {
         _map.content.addChild(this._hemaMc);
         _processor.showMouseHintOver(this._hemaMc["pet"]);
         this._hemaMc["pet"].buttonMode = true;
         this._hemaMc["pet"].addEventListener(MouseEvent.CLICK,this.onPetClickStep5);
      }
      
      private function onPetClickStep5(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._hemaMc["pet"].buttonMode = false;
         this._hemaMc["pet"].removeEventListener(MouseEvent.CLICK,this.onPetClickStep5);
         _processor.hideMouseClickHint();
         DisplayObjectUtil.removeFromParent(this._hemaMc);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("7_0"),function():void
         {
            DialogPanel.showForSimple(11,"多罗",[[1,"它们是住在水脉氏族的水墨点点，走！哥哥带你们回家！"]],"（多罗母爱泛滥……）",function():void
            {
               QuestProcessor_7(_processor).disposeHaima();
               MovieClipUtil.playMc(_stepAnimation1,2,_stepAnimation1.totalFrames,function():void
               {
                  QuestProcessor_7(_processor).disposeHaima();
                  DisplayObjectUtil.removeFromParent(_stepAnimation1);
                  QuestManager.completeStep(_quest.id,5);
               },true);
            });
         });
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep2);
      }
   }
}
