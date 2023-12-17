package com.taomee.seer2.app.processor.quest.handler.main.quest14
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_14_192 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_14_192(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
         var _loc2_:String = param1.params;
         if(_loc2_ == "14_0")
         {
            this.playAcceptTalkNew();
         }
      }
      
      private function playAcceptTalkNew() : void
      {
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("14_0"),2,[[1,0]],function():void
         {
            NpcDialog.show(31,"巴尔卡",[[0,ActorManager.actorInfo.nick + "，如今我能信任的人只有你和麦铁了，我希望你能助我一臂之力，找到顿炎！可是没人见过……"]],["囧……这可怎么办是好！？"],[function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[4,"啊啊啊啊 ！！我想到了！邦妮婆婆！那个神奇的料理占卜！！！占卜婆婆一定知道！我先去找他！"]],["（婆婆在狂暴漩涡）"],[function():void
               {
                  QuestManager.accept(_quest.id);
               }]);
            }]);
         });
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
      }
   }
}
