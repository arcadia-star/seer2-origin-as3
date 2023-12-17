package com.taomee.seer2.app.processor.quest.handler.branch.quest10235
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
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
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10235_80145 extends QuestMapHandler
   {
      
      private static var haveFight:int = 0;
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      public function QuestMapHandler_10235_80145(param1:QuestProcessor)
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
         if(haveFight == 1)
         {
            haveFight = 0;
            this.gameOver(null);
            return;
         }
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,2))
         {
            this.initStep1();
         }
         if(QuestManager.isStepComplete(questID,2) && !QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10235)
         {
            this._mc1 = null;
            this._mc2 = null;
            MobileManager.showMoileVec(MobileType.NPC);
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
            SceneManager.changeScene(SceneType.LOBBY,70);
         }
      }
      
      private function initStep1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc10235_2");
         _map.content.addChild(this._mc1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            NpcDialog.show(12,"萨伦",[[0,"奇怪的石头……看来有必要仔细的研究看看。"]],["萨伦王"],[function():void
            {
               NpcDialog.show(12,"萨伦",[[0,"你说是不是……梦神大人。"]],["梦神大人？"],[function():void
               {
                  NpcDialog.show(770,"迷之黑影",[[0,"奇怪的石头，没猜错的话，应该就是星魂石……"]],["星魂石？"],[function():void
                  {
                     NpcDialog.show(770,"迷之黑影",[[0,"可是，阿卡迪亚星上应该已经没有星魂石了才对。"]],["来自地球的星魂石  "],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc1);
                        initStep2();
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep2() : void
      {
         this._mc2 = _processor.resLib.getMovieClip("Mc10235_3");
         _map.content.addChild(this._mc2);
         MovieClipUtil.playMc(this._mc2,1,this._mc2.totalFrames,function():void
         {
            NpcDialog.show(771,"梦神",[[0,"一群废物，居然想阻止我的计划！"]],["梦神看起来好强！ "],[function():void
            {
               NpcDialog.show(766,"小梦",[[0,"你就是幕后黑手吗！？"]],["那个黑影？"],[function():void
               {
                  NpcDialog.show(771,"梦神",[[0,"哈哈，你就是拥有星魂的小精灵吧。快，把星魂石交给我，我还能饶你们不死"]],["就是包裹里的石头吧 "],[function():void
                  {
                     NpcDialog.show(766,"小梦",[[0,"师父给的石头才不会给你呢！"]],["不会交给你的！ "],[function():void
                     {
                        NpcDialog.show(771,"梦神",[[0,"那就别怪我来硬的了！"]],["攻过来吧！"],[function():void
                        {
                           NpcDialog.show(406,"目灵兽",[[0,"小心！这个敌人不是你们能应付的对手！"]],["那么强？！！"],[function():void
                           {
                              DisplayObjectUtil.removeFromParent(_mc2);
                              MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10235_0"),function():void
                              {
                                 haveFight = 1;
                                 FightManager.startFightWithWild(1136);
                              });
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function gameOver(param1:SceneEvent) : void
      {
         if(FightManager.currentFightRecord.initData.positionIndex == 1136)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.initStep3();
            }
            else if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               this.initStep3();
            }
         }
      }
      
      private function initStep3() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10235_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
            QuestManager.completeStep(questID,2);
         });
      }
   }
}
