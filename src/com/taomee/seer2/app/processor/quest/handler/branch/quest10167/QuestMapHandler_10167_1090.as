package com.taomee.seer2.app.processor.quest.handler.branch.quest10167
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
   
   public class QuestMapHandler_10167_1090 extends QuestMapHandler
   {
       
      
      private var _map10167:MovieClip;
      
      public function QuestMapHandler_10167_1090(param1:QuestProcessor)
      {
         super(param1);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.update10167();
         }
      }
      
      override public function processMapComplete() : void
      {
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.update10167();
            ItemManager.requestItemList(function():void
            {
               var _loc1_:uint = uint(ItemManager.getItemQuantityByReferenceId(400266));
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
      
      private function update10167() : void
      {
         if(Boolean(SceneManager.active) && Boolean(SceneManager.active.mapModel))
         {
            this._map10167 = SceneManager.active.mapModel.content["map10167"];
            this._map10167.buttonMode = true;
            this._map10167.addEventListener(MouseEvent.CLICK,this.onMap10167);
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
            this._map10167 = SceneManager.active.mapModel.content["map10167"];
            this._map10167.addEventListener(MouseEvent.CLICK,this.onMap10167);
         }
      }
      
      private function onMap10167(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DayLimitManager.getDoCount(596,function(param1:uint):void
         {
            var count:uint = param1;
            if(count == 0)
            {
               SwapManager.swapItem(966,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1,false);
                  ServerMessager.addMessage("获得了冬日竹笋");
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                  QuestManager.completeStep(_quest.id,1);
               });
            }
         });
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.removeEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.removeEventListener(Event.ENTER_FRAME,this.onFrame);
      }
   }
}
