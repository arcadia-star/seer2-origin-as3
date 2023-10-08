package com.taomee.seer2.app.processor.quest.handler.main.quest14
{
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_14_170 extends QuestMapHandler
   {
       
      
      private var _storeTrigger:MovieClip;
      
      public function QuestMapHandler_14_170(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._storeTrigger = _map.content["storeTrigger"];
            this._storeTrigger.addEventListener(MouseEvent.CLICK,this.onStoreTriggerClick);
         }
      }
      
      private function onStoreTriggerClick(param1:MouseEvent) : void
      {
         ServerMessager.addMessage("获得任务道具月光之眼");
         this._storeTrigger.removeEventListener(MouseEvent.CLICK,this.onStoreTriggerClick);
         QuestManager.completeStep(_quest.id,2);
      }
      
      override public function processMapDispose() : void
      {
         if(this._storeTrigger)
         {
            this._storeTrigger.removeEventListener(MouseEvent.CLICK,this.onStoreTriggerClick);
            this._storeTrigger = null;
         }
      }
   }
}
