package com.taomee.seer2.app.processor.quest.handler.branch.quest10030
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10030_160 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_10030_160(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._npc = MobileManager.getMobile(23,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpc,false,1);
         }
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         NpcDialog.show(23,"洛水",[[0,"草目氏族酋长身体可好？这是水脉氏族的止咳水，它或许可以减缓酋长的病痛！希望他早日康复！麻烦你带我问候酋长！"]],["（酋长能有特鲁伊作伴真令人羡慕）"]);
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var _loc2_:String = param1.params;
         if(_loc2_ == "10030_0")
         {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            ServerMessager.addMessage("已收集完成");
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete);
            QuestManager.completeStep(_quest.id,1);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         if(QuestManager.isComplete(10028) && QuestManager.isComplete(10029) && QuestManager.isComplete(10030) && QuestManager.isComplete(10031))
         {
            QuestManager.accept(10032);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
      }
   }
}
