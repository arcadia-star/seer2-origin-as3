package com.taomee.seer2.app.processor.quest.handler.branch.quest10243
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10243_80323 extends QuestMapHandler
   {
       
      
      private var _mc10242_0:MovieClip;
      
      public function QuestMapHandler_10243_80323(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.hideActor();
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,2))
         {
            this.init();
         }
         if(QuestManager.isStepComplete(questID,2) && !QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc10242_0 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.COPY,80324);
      }
      
      private function init() : void
      {
         NpcDialog.show(400,"小赛尔",[[0,"原来开元大帝还有这样的故事！"]],["他还没从分裂星球的噩梦中解脱！"],[function():void
         {
            NpcDialog.show(774,"超梦",[[0,"那怎么办呢？没有开元的力量阿卡迪亚会被邪神占领的！"]],["老婆婆想想办法吧！"],[function():void
            {
               NpcDialog.show(27,"占卜婆婆",[[0,"办法是有一个，你们可以先去寻找混沌大帝。"]],["寻找混沌？"],[function():void
               {
                  NpcDialog.show(400,"小赛尔",[[0,"可是我们没有召唤混沌大帝的石头啊！"]],["怎么召唤混沌呢？"],[function():void
                  {
                     NpcDialog.show(27,"占卜婆婆",[[0,"如果我没记错，召唤混沌大帝可不用什么石头哦~"]],["啊？"],[function():void
                     {
                        NpcDialog.show(27,"占卜婆婆",[[0,"你们拿着开元石到风暴悬崖看下吧，说不定还有比混沌大帝更意外的发现呢！嘿嘿嘿~"]],["好的！"],[function():void
                        {
                           DisplayObjectUtil.removeFromParent(_mc10242_0);
                           QuestManager.completeStep(questID,2);
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onComplete);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
   }
}
