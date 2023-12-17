package com.taomee.seer2.app.processor.quest.handler.branch.quest10244
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
   
   public class QuestMapHandler_10244_80328 extends QuestMapHandler
   {
       
      
      private var _mc10243_0:MovieClip;
      
      private var _mc10244_0:MovieClip;
      
      private var _mc10244_1:MovieClip;
      
      public function QuestMapHandler_10244_80328(param1:QuestProcessor)
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
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.init();
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc10243_0 = null;
         this._mc10244_0 = null;
         this._mc10244_1 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function init() : void
      {
         this._mc10243_0 = _processor.resLib.getMovieClip("Mc10244_0");
         _map.content.addChild(this._mc10243_0);
         this._mc10243_0.gotoAndStop(1);
         NpcDialog.show(820,"混沌大帝",[[0,"阿卡迪亚分裂计划……"]],["分裂计划！！！！"],[function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"那是什么？"]],["听起来很不妙"],[function():void
            {
               NpcDialog.show(820,"混沌大帝",[[0,"我创造了阿卡迪亚的正义与邪恶，正义与邪恶却在持续斗争，持续了很久很久，生灵涂炭。"]],["正义与邪恶"],[function():void
               {
                  NpcDialog.show(820,"混沌大帝",[[0,"于是我想到了一个非常冒险的方式，将星球一分为二，一边全是邪恶，而另一边，全是正义！"]],[" 这……"],[function():void
                  {
                     NpcDialog.show(820,"混沌大帝",[[0,"这也就是阿卡迪亚分裂计划！当然，我一个人的力量，是不够执行这个计划的……"]],["？"],[function():void
                     {
                        NpcDialog.show(820,"混沌大帝",[[0,"我需要借助创世和开元的力量……"]],["！！！！"],[function():void
                        {
                           MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10244_0"),function():void
                           {
                              initContinue();
                           });
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function initContinue() : void
      {
         NpcDialog.show(820,"混沌大帝",[[0,"也就是说，导致星球分裂的最大责任应该在我。"]],["混沌……"],[function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"那开元为什么还那么自负！？"]],["为什么？？？"],[function():void
            {
               NpcDialog.show(820,"混沌大帝",[[0,"因为再怎么说，约瑟和奎尔斯也是他创造的。"]],["诶……"],[function():void
               {
                  initStep1();
                  DisplayObjectUtil.removeFromParent(_mc10243_0);
               }]);
            }]);
         }]);
      }
      
      private function initStep1() : void
      {
         this._mc10244_0 = _processor.resLib.getMovieClip("Mc10244_0");
         _map.front.addChild(this._mc10244_0);
         this._mc10244_0.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10244_0,1,this._mc10244_0.totalFrames,function():void
         {
            NpcDialog.show(815,"邪神",[[0,"哈哈，混沌！终于找到你了！杀光三帝，阿卡迪亚就是我的了！"]],["邪神！"],[function():void
            {
               NpcDialog.show(816,"创世大帝",[[0,"混沌……开元呢……再慢一些……这颗星球就真的完了。"]],["创世已经被击败了！"],[function():void
               {
                  NpcDialog.show(820,"混沌大帝",[[0,"可恶，最糟糕的情况发生了！"]],["怎么办？"],[function():void
                  {
                     NpcDialog.show(820,"混沌大帝",[[0,"小赛尔！超梦！你们先再去找开元！我在这里抵挡着！"]],["好！"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc10244_0);
                        initStep2();
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep2() : void
      {
         this._mc10244_1 = _processor.resLib.getMovieClip("Mc10244_1");
         _map.content.addChild(this._mc10244_1);
         this._mc10244_1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10244_1,1,this._mc10244_1.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(_mc10244_1);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10244_1"),function():void
            {
               QuestManager.completeStep(questID,1);
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
            });
         },true);
      }
   }
}
