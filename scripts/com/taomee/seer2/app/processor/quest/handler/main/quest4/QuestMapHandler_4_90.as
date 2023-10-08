package com.taomee.seer2.app.processor.quest.handler.main.quest4
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_4_90 extends QuestMapHandler
   {
       
      
      private var _stepAnimation:MovieClip;
      
      public function QuestMapHandler_4_90(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.isStepCompete(3))
         {
            if(!_quest.isStepCompete(4))
            {
               this.processStep4();
            }
            else if(!_quest.isStepCompete(5))
            {
               this.processStep5();
            }
            else if(!_quest.isStepCompete(6))
            {
               this.processStep6();
            }
            else if(!_quest.isStepCompete(7))
            {
               this.processStep7();
            }
         }
      }
      
      private function processStep4() : void
      {
         DialogPanel.showForSimple(17,"特鲁伊",[[0,"尊贵的客人，你不需要保护我，酋长的病情很严重，我想我们还是分头行动吧！"]],"好！你一定要小心！",function():void
         {
            DialogPanel.showForSimple(17,"特鲁伊",[[0,"我去深幽沼泽寻找幽藤种子，你去 <font color=\'#ffcc00\'>水仙溪口</font> 寻找 <font color=\'#ffcc00\'>蔓藤花粉</font>，记得七彩蛙会给你提示。"]],"等……等一下",function():void
            {
               _stepAnimation = _map.content["quest_4"];
               MovieClipUtil.playMc(_stepAnimation,2,_stepAnimation.totalFrames,function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete4);
                  QuestManager.completeStep(_quest.id,4);
               },true);
            });
         });
      }
      
      private function onStepComplete4(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete4);
            this.processStep5();
         }
      }
      
      private function processStep5() : void
      {
         _processor.showMouseHintAt(-70,405);
      }
      
      private function processStep6() : void
      {
         DialogPanel.showForSimple(400,"我",[[0,"咦？特鲁伊怎么还没回来？"]],"前往深幽沼泽……",function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete6);
            QuestManager.completeStep(_quest.id,6);
         });
      }
      
      private function onStepComplete6(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete6);
            this.processStep7();
         }
      }
      
      private function processStep7() : void
      {
         _processor.showMouseHintAt(500,150);
      }
   }
}
