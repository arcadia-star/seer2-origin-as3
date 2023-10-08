package com.taomee.seer2.app.processor.quest.handler.branch.quest10245
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
   
   public class QuestMapHandler_10245_80332 extends QuestMapHandler
   {
       
      
      private var _mc10245_1:MovieClip;
      
      private var _mc10245_2:MovieClip;
      
      private var _mc10245_3:MovieClip;
      
      public function QuestMapHandler_10245_80332(param1:QuestProcessor)
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
         this._mc10245_1 = null;
         this._mc10245_2 = null;
         this._mc10245_3 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initstep1() : void
      {
         this._mc10245_1 = _processor.resLib.getMovieClip("Mc10245_1");
         _map.content.addChild(this._mc10245_1);
         this._mc10245_1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10245_1,1,this._mc10245_1.totalFrames,function():void
         {
            NpcDialog.show(820,"混沌大帝",[[0,"开元！你终于来了！"]],[" 是的！"],[function():void
            {
               NpcDialog.show(817,"开元大帝",[[0,"抱歉，让你们久等了。"]],["三帝齐聚！"],[function():void
               {
                  NpcDialog.show(815,"邪神",[[0,"哈哈，那又怎么样，两个已经伤了，一个战意全无，这样就能打败我吗？"]],["邪神！别嚣张！"],[function():void
                  {
                     NpcDialog.show(816,"创世大帝",[[0,"邪神，现在就让你见识下，三帝的真正姿态！"]],["哇！"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10245_1"),function():void
                        {
                           DisplayObjectUtil.removeFromParent(_mc10245_1);
                           initstep2();
                        });
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initstep2() : void
      {
         this._mc10245_2 = _processor.resLib.getMovieClip("Mc10245_2");
         _map.content.addChild(this._mc10245_2);
         this._mc10245_2.gotoAndStop(1);
         NpcDialog.show(400,"小赛尔",[[0,"邪神……被封印了吗……"]],["三帝好厉害……"],[function():void
         {
            NpcDialog.show(817,"开元大帝",[[0,"是的，邪神，应该不会再出现了。"]],["胜利咯！"],[function():void
            {
               NpcDialog.show(817,"开元大帝",[[0,"不过我们三个也耗尽了气力，看来又要休息几百年了。"]],["要分开了吗……"],[function():void
               {
                  NpcDialog.show(820,"混沌大帝",[[0,"可恶，好不容易苏醒一次还是没完成分裂计划。"]],[" 哈哈，还想着分裂计划"],[function():void
                  {
                     NpcDialog.show(816,"创世大帝",[[0,"我也还没玩够呢！又要睡了……"]],["你就别玩啦……"],[function():void
                     {
                        NpcDialog.show(817,"开元大帝",[[0,"小赛尔，超梦。代我向水系氏族的少女告别吧。"]],["婆婆吗……"],[function():void
                        {
                           NpcDialog.show(817,"开元大帝",[[0,"再见了，有机会，会再见的。"]],["再见开元！"],[function():void
                           {
                              NpcDialog.show(816,"创世大帝",[[0,"886~"]],["再见创世！"],[function():void
                              {
                                 NpcDialog.show(820,"混沌大帝",[[0,"再见啦，这样的阿卡迪亚，也很不错嘛~"]],["再见混沌！"],[function():void
                                 {
                                    DisplayObjectUtil.removeFromParent(_mc10245_2);
                                    initstep3();
                                 }]);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function initstep3() : void
      {
         this._mc10245_3 = _processor.resLib.getMovieClip("Mc10245_2");
         _map.content.addChild(this._mc10245_3);
         this._mc10245_3.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10245_3,1,this._mc10245_3.totalFrames,function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"三帝……再见了……"]],[" 会再见的！"],[function():void
            {
               NpcDialog.show(774,"超梦",[[0,"别发呆了小赛尔！快回去向船长报告吧！"]],["对哦！"],[function():void
               {
                  NpcDialog.show(400,"小赛尔",[[0,"好！第七小队！任务完成！！！"]],["Yeah~"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10245_2"),function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc10245_3);
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
