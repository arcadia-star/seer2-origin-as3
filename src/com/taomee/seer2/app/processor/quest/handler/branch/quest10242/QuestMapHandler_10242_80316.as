package com.taomee.seer2.app.processor.quest.handler.branch.quest10242
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
   
   public class QuestMapHandler_10242_80316 extends QuestMapHandler
   {
       
      
      private var _mc10242_1:MovieClip;
      
      private var _mc10242_2:MovieClip;
      
      private var _mc10242_3:MovieClip;
      
      public function QuestMapHandler_10242_80316(param1:QuestProcessor)
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
            this.initstep1();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc10242_1 = null;
         this._mc10242_2 = null;
         this._mc10242_3 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initstep1() : void
      {
         this._mc10242_1 = _processor.resLib.getMovieClip("Mc10242_1");
         _map.front.addChild(this._mc10242_1);
         this._mc10242_1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10242_1,1,this._mc10242_1.totalFrames,function():void
         {
            NpcDialog.show(27,"占卜婆婆",[[0,"看你们的样子，是在召唤开元大帝吧？"]],["占卜婆婆？"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"是啊！可是召唤不出！"]],["到底怎么回事？"],[function():void
               {
                  NpcDialog.show(27,"占卜婆婆",[[0,"来，把石头给我。"]],["婆婆来召唤吗？"],[function():void
                  {
                     DisplayObjectUtil.removeFromParent(_mc10242_1);
                     initstep2();
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initstep2() : void
      {
         this._mc10242_2 = _processor.resLib.getMovieClip("Mc10242_2");
         _map.front.addChild(this._mc10242_2);
         this._mc10242_2.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10242_2,1,this._mc10242_2.totalFrames,function():void
         {
            NpcDialog.show(817,"开元大帝",[[0,"水系氏族的子民，我依据契约出现在尔等面前，唤本王来何事？"]],["契约？"],[function():void
            {
               NpcDialog.show(27,"占卜婆婆",[[0,"大帝，这两位外族人似乎有急事找您。"]],["外族人？"],[function():void
               {
                  NpcDialog.show(817,"开元大帝",[[0,"非水系氏族子民本王一律不见！回去吧。"]],["开元大帝怎么这样！？"],[function():void
                  {
                     NpcDialog.show(400,"小赛尔",[[0,"大帝！我们找你是为了邪神的事！"]],["邪神来了！"],[function():void
                     {
                        NpcDialog.show(817,"开元大帝",[[0,"那又与我何干，不送了两位。"]],["开元大帝！！"],[function():void
                        {
                           DisplayObjectUtil.removeFromParent(_mc10242_2);
                           initstep3();
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initstep3() : void
      {
         this._mc10242_3 = _processor.resLib.getMovieClip("Mc10242_3");
         _map.front.addChild(this._mc10242_3);
         this._mc10242_3.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10242_3,1,this._mc10242_3.totalFrames,function():void
         {
            NpcDialog.show(27,"占卜婆婆",[[0,"诶，看来大帝的心结还是没有解开。"]],["心结？"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"发生什么了？"]],["为什么开元大帝只和水系氏族有契约？"],[function():void
               {
                  NpcDialog.show(27,"占卜婆婆",[[0,"事情是这样的…………"]],["………"],[function():void
                  {
                     DisplayObjectUtil.removeFromParent(_mc10242_3);
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10242_1"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                        QuestManager.completeStep(questID,2);
                     });
                  }]);
               }]);
            }]);
         },true);
      }
   }
}
