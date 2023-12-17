package com.taomee.seer2.app.processor.quest.handler.branch.quest10021
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
   
   public class QuestMapHandler_10021_152 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10021_152(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.getQuest(_quest.id).status == QuestStatus.IN_PROGRESS)
         {
            NpcDialog.show(443,"埃卡维特",[[0,"55555~~~~太感人了！我都内牛满面了呢！这可比TVB、韩剧、美剧精彩多了！来，埃卡给你奇妙扑克！"]],["（凑齐100张奇妙扑克就来传送舱找我）"],[function():void
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
