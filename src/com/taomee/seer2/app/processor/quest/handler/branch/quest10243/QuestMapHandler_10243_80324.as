package com.taomee.seer2.app.processor.quest.handler.branch.quest10243
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
   
   public class QuestMapHandler_10243_80324 extends QuestMapHandler
   {
       
      
      private var _mc10243_0:MovieClip;
      
      public function QuestMapHandler_10243_80324(param1:QuestProcessor)
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
         MobileManager.hideMoileVec(MobileType.NPC);
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1))
         {
            this.init();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc10243_0 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function init() : void
      {
         this._mc10243_0 = _processor.resLib.getMovieClip("Mc10243_1");
         _map.content.addChild(this._mc10243_0);
         this._mc10243_0.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10243_0,1,this._mc10243_0.totalFrames,function():void
         {
            NpcDialog.show(820,"混沌大帝",[[0,"原来是开元石，误让我以为是开元的来了呢。说吧，什么事。"]],["发生大事了！"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10243_1"),function():void
               {
                  initContinue();
               });
            }]);
         },true);
      }
      
      private function initContinue() : void
      {
         NpcDialog.show(820,"混沌大帝",[[0,"简单说，邪神出现了，开元不肯出战，是吧？"]],["没错！"],[function():void
         {
            NpcDialog.show(820,"混沌大帝",[[0,"哈哈哈哈哈哈哈哈哈哈！！！！！"]],["混沌大帝你笑什么？"],[function():void
            {
               NpcDialog.show(820,"混沌大帝",[[0,"你们只知道开元制造了约瑟和奎尔斯，但你们知不知道约瑟和奎尔斯是为什么打起来吗？"]],["这个不清楚！"],[function():void
               {
                  NpcDialog.show(820,"混沌大帝",[[0,"没想到开元那家伙还在为这件事自负，难得你们能找到我，就告诉你们吧。"]],["好！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10243_2"),function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc10243_0);
                        QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                        QuestManager.completeStep(questID,2);
                     });
                  }]);
               }]);
            }]);
         }]);
      }
   }
}
