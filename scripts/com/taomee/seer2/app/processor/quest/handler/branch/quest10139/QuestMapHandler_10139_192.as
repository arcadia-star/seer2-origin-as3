package com.taomee.seer2.app.processor.quest.handler.branch.quest10139
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.utils.IDataInput;
   
   public class QuestMapHandler_10139_192 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_10139_192(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isStepComplete(_quest.id,4) && QuestManager.isStepComplete(_quest.id,5) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep1);
         }
         if(QuestManager.isStepComplete(_quest.id,5) && QuestManager.isStepComplete(_quest.id,6) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep2);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "10139_2")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Handler);
            QuestManager.completeStep(_quest.id,4);
         }
      }
      
      private function onStep4Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Handler);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep1);
      }
      
      private function onStep1(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "10139_3")
         {
            ItemManager.requestItemList(function():void
            {
               if(ItemManager.getItemByReferenceId(400015))
               {
                  SwapManager.swapItem(712,1,function(param1:IDataInput):void
                  {
                     var data:IDataInput = param1;
                     DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,onStep1);
                     NpcDialog.show(31,"巴尔卡",[[0,"麻里麻里哄，霹雳碰隆赤，火幻花快快开吧~"]],["谢谢巴尔卡（获得火幻花）"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep5CompleteHandler);
                        QuestManager.completeStep(_quest.id,5);
                     }]);
                  });
               }
               else
               {
                  NpcDialog.show(31,"巴尔卡",[[0,"如果还没找到的话，火幻花是不能盛开的哟。"]],["（去蛮神战场找到赤炎火苗）"]);
               }
            });
         }
      }
      
      private function onStep5CompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep5CompleteHandler);
         this.npcTalk();
      }
      
      private function onStep2(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "10139_4")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep1);
            this.npcTalk();
         }
      }
      
      private function npcTalk() : void
      {
         NpcDialog.show(31,"巴尔卡",[[0,"我想你该去问问神谕祭司了。"]],["出发！访问神谕祭司"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep6CompleteHandler);
            QuestManager.completeStep(_quest.id,6);
         }]);
      }
      
      private function onStep6CompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep6CompleteHandler);
         SceneManager.changeScene(SceneType.LOBBY,160);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Handler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep5CompleteHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep6CompleteHandler);
      }
   }
}
