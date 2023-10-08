package com.taomee.seer2.app.processor.quest.handler.branch.quest10019
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
   
   public class QuestMapHandler_10019_193 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10019_193(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.getQuest(_quest.id).status == QuestStatus.IN_PROGRESS)
         {
            NpcDialog.show(443,"埃卡维特",[[0,"哎呦我滴妈呀，他们怎么各个都这么厉害！我也要成为宇宙超级无敌厉害的埃卡维特SPT！哇卡卡卡！我越来越喜欢你，奇妙扑克拿好咯！"]],["（凑齐100张奇妙扑克，去传送舱领埃卡维特）"],[function():void
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
