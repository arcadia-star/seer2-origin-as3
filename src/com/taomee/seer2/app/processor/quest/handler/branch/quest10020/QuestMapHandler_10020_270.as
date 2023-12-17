package com.taomee.seer2.app.processor.quest.handler.branch.quest10020
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10020_270 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10020_270(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.getQuest(_quest.id).status == QuestStatus.IN_PROGRESS)
         {
            NpcDialog.show(443,"埃卡维特",[[0,"热热热热！埃卡一分钟都呆不下去了！走啦走啦！我们走了嘛！埃卡要把最心爱的奇妙扑克送给你！嘻嘻O(∩_∩)O"]],["（凑够100张奇妙扑克，偶就带你回家！）"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               QuestManager.completeStep(_quest.id,1);
            }]);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         var _loc2_:Mobile = new Mobile();
         _loc2_.resourceUrl = URLUtil.getPetSwf(109);
         ActorManager.getActor().removeCarriedMobile(_loc2_);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
   }
}
