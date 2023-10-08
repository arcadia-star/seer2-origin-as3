package com.taomee.seer2.app.processor.quest.handler.branch.quest10169
{
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class QuestMapHandler_10169_1090 extends QuestMapHandler
   {
       
      
      private var _map10169:MovieClip;
      
      public function QuestMapHandler_10169_1090(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.update10169();
            ItemManager.requestItemList(function():void
            {
               var _loc1_:uint = uint(ItemManager.getItemQuantityByReferenceId(400268));
               if(_loc1_ >= 1)
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                  QuestManager.completeStep(_quest.id,1);
               }
            });
         }
         else if(QuestManager.isCanAccepted(_quest.id))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.update10169();
         }
      }
      
      private function update10169() : void
      {
         if(Boolean(SceneManager.active) && Boolean(SceneManager.active.mapModel))
         {
            this._map10169 = SceneManager.active.mapModel.content["map10169"];
            this._map10169.buttonMode = true;
            this._map10169.addEventListener(MouseEvent.CLICK,this.onMap10169);
         }
         else
         {
            SceneManager.addEventListener(Event.ENTER_FRAME,this.onFrame);
         }
      }
      
      private function onFrame(param1:Event) : void
      {
         if(Boolean(SceneManager.active) && Boolean(SceneManager.active.mapModel))
         {
            SceneManager.removeEventListener(Event.ENTER_FRAME,this.onFrame);
            this._map10169 = SceneManager.active.mapModel.content["map10169"];
            this._map10169.buttonMode = true;
            this._map10169.addEventListener(MouseEvent.CLICK,this.onMap10169);
         }
      }
      
      private function onMap10169(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DayLimitManager.getDoCount(598,function(param1:uint):void
         {
            var count:uint = param1;
            if(count == 0)
            {
               SwapManager.swapItem(972,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1,false);
                  ServerMessager.addMessage("获得了不朽花蜜");
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                  QuestManager.completeStep(_quest.id,1);
               });
            }
         });
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         SceneManager.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         SceneManager.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
   }
}
