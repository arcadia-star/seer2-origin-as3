package com.taomee.seer2.app.processor.quest.handler.branch.quest10239
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10239_80301 extends QuestMapHandler
   {
       
      
      private var _mc4:MovieClip;
      
      public function QuestMapHandler_10239_80301(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         MobileManager.hideMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.hideActor();
         MobileManager.hideMoileVec(MobileType.NPC);
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2))
         {
            this.initStep2();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc4 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep2() : void
      {
         this._mc4 = _processor.resLib.getMovieClip("Mc10239_3");
         _map.front.addChild(this._mc4);
         this._mc4.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc4,1,this._mc4.totalFrames,function():void
         {
            NpcDialog.show(814,"约瑟王",[[0,"最糟糕的事情发生了，萨伦召唤出了邪神。"]],["邪神？"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"邪神是谁？"]],["听起来很厉害的样子"],[function():void
               {
                  NpcDialog.show(814,"约瑟王",[[0,"邪神，是一个我无法与他战斗的敌人。"]],["为什么？"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10239_1"),function():void
                     {
                        initContinue();
                     });
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initContinue() : void
      {
         NpcDialog.show(814,"约瑟王",[[0,"我无法与这颗星球本身的意志相抗衡，这场战斗，无法帮助你们。"]],["这可怎么办？"],[function():void
         {
            NpcDialog.show(814,"约瑟王",[[0,"能拯救这颗星球的，只有你们，超梦、小赛尔。"]],["拯救阿卡迪亚！"],[function():void
            {
               DisplayObjectUtil.removeFromParent(_mc4);
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10239_2"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                  QuestManager.completeStep(questID,2);
               });
            }]);
         }]);
      }
   }
}
