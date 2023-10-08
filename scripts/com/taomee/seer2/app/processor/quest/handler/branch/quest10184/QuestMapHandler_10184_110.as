package com.taomee.seer2.app.processor.quest.handler.branch.quest10184
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10184_110 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10184_110(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepOne);
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepOne);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepTwo);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "10184_0")
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10184_0"),function():void
            {
               QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
               QuestManager.accept(_quest.id);
            },true,false,2);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         ModuleManager.addEventListener("ChameleonDancePanel","DanceGameOneSuccess",this.onSucessDancePanel);
         ModuleManager.toggleModule(URLUtil.getAppModule("ChameleonDancePanel"),"正在打开面板...");
      }
      
      private function onStepOne(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "10184_1" && QuestManager.isAccepted(_quest.id))
         {
            ModuleManager.addEventListener("ChameleonDancePanel","DanceGameOneSuccess",this.onSucessDancePanel);
            ModuleManager.toggleModule(URLUtil.getAppModule("ChameleonDancePanel"),"正在打开面板...");
         }
      }
      
      private function onSucessDancePanel(param1:ModuleEvent) : void
      {
         var evr:ModuleEvent = param1;
         ModuleManager.removeEventListener("ChameleonDancePanel","DanceGameOneSuccess",this.onSucessDancePanel);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10184_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteOneHandler);
            QuestManager.completeStep(_quest.id,1);
         },true,false,2);
      }
      
      private function onCompleteOneHandler(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteOneHandler);
         NpcDialog.show(16,"神目酋长",[[0,"可恶的萨伦帝国又在肆无忌惮的破坏我们的家园了。不行，我们必须依靠自己的力量强大起来，对抗萨伦。"]],["强大起来！"],[function():void
         {
            chameleonTalk();
         }]);
      }
      
      private function onStepTwo(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "10184_2" && QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.chameleonTalk();
         }
      }
      
      private function chameleonTalk() : void
      {
         NpcDialog.show(576,"变色蜥",[[0,"是的，我们必须将我们的精灵训练有素，同萨伦做抵抗。但是……但是……"]],["噗……"],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10184_2"),function():void
            {
               NpcDialog.show(16,"神目酋长",[[0,"抵抗萨伦帝国是我们的责任，我们一起来参加前所未有的精灵训练营，训练强大的精灵吧。"]],["参加精灵训练营咯"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleteHandler);
                  QuestManager.completeStep(_quest.id,2);
               }]);
            },true,false,2);
         }]);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
         ModuleManager.toggleModule(URLUtil.getAppModule("PetTrainTogetherPanel"),"正在打开面板...");
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepOne);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepTwo);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteOneHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
   }
}
