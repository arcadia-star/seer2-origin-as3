package com.taomee.seer2.app.processor.quest.handler.branch.quest10139
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_10139_110 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10139_110(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep1);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "10139_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"孔雀开屏是为了给族人们祈福，带来和平，而族人们却滥用祈福，导致了孔雀再也不开屏了。"]],["酋长，可以停止战争吗？"],[function():void
            {
               NpcDialog.show(16,"神目酋长",[[0,"原来如此，我们误解了孔雀的祈福，原来孔雀是祈祷停止战争啊，我们误解了误解了……"]],["不用怕，我们来做一个象征和平的花环吧"],[function():void
               {
                  NpcDialog.show(16,"神目酋长",[[0,"对，我们应该团结起来，你可以去水仙草界采集一束草目氏族特有的草目花。"]],["好的，我这就去水仙草界"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Handler);
                     QuestManager.completeStep(_quest.id,1);
                  }]);
               }]);
            }]);
         }
      }
      
      private function onStep1Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         SceneManager.changeScene(SceneType.LOBBY,151);
      }
      
      private function onStep1(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "10139_1")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
            QuestManager.completeStep(_quest.id,3);
         }
      }
      
      private function onStep3Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
         SceneManager.changeScene(SceneType.LOBBY,192);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
      }
   }
}
