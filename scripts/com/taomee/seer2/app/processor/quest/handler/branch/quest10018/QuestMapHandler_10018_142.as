package com.taomee.seer2.app.processor.quest.handler.branch.quest10018
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
   
   public class QuestMapHandler_10018_142 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10018_142(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.getQuest(_quest.id).status == QuestStatus.IN_PROGRESS)
         {
            NpcDialog.show(443,"埃卡维特",[[0,"矮油，这个家伙看起来很凶相的嘛！待我高级一点，我再来修理它。不管怎么样，谢谢你带我逛逛。给！这是我最心爱的奇妙扑克！"]],["（嘘！凑齐100张奇妙扑克，埃卡维特就跟定你咯！）"],[function():void
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
