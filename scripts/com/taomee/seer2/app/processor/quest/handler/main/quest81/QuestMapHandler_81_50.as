package com.taomee.seer2.app.processor.quest.handler.main.quest81
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_81_50 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_81_50(param1:QuestProcessor)
      {
         super(param1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && QuestManager.isStepComplete(questID,2) && !QuestManager.isStepComplete(questID,3))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "81_2")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            this.initStep();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._npc = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,20);
      }
      
      private function createNpc() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc)
         {
            this._npc = MobileManager.getMobile(4,MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -150;
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep,false,1);
         }
      }
      
      private function initStep() : void
      {
         NpcDialog.show(4,"菲鲁",[[0,"唔，那我可得再去检查一下那上面有没有哪个螺丝帽松动了……啊对了，伊娃博士好像也在等着你们呢！"]],["（前往实验室）"],[function():void
         {
            initContinue();
         }]);
      }
      
      private function initContinue() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         QuestManager.completeStep(questID,3);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
   }
}
