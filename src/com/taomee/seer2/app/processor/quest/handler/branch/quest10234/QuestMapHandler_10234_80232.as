package com.taomee.seer2.app.processor.quest.handler.branch.quest10234
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10234_80232 extends QuestMapHandler
   {
      
      private static var haveFight:int = 0;
       
      
      private const FIGHT_ID1:uint = 1116;
      
      private const FIGHT_ID2:uint = 1117;
      
      private var sceneMc:MovieClip;
      
      public function QuestMapHandler_10234_80232(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.getActor().hide();
         if(haveFight == 1)
         {
            haveFight = 0;
            this.gameOver(null);
            return;
         }
         if(QuestManager.isStepComplete(10234,1) == false)
         {
            this.initStep1();
         }
      }
      
      private function gameOver(param1:SceneEvent) : void
      {
         if(FightManager.currentFightRecord.initData.positionIndex == this.FIGHT_ID1 || FightManager.currentFightRecord.initData.positionIndex == this.FIGHT_ID2)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
            {
               if(FightManager.currentFightRecord.initData.positionIndex == this.FIGHT_ID1)
               {
                  this.initStep3();
               }
               else
               {
                  this.initStep4();
               }
            }
            else if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               if(FightManager.currentFightRecord.initData.positionIndex == this.FIGHT_ID1)
               {
                  this.initStep2();
               }
               else
               {
                  this.initStep4();
               }
            }
         }
      }
      
      private function initStep2() : void
      {
         NpcDialog.show(13,"阿修",[[1,"小铁罐，又想来挑战我吗？!"]],["来战！","先休息一会儿"],[this.toFight,this.changeScene]);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         this.initStep1();
      }
      
      private function initStep1() : void
      {
         this.sceneMc = _processor.resLib.getMovieClip("SceneMc_0");
         _map.content.addChild(this.sceneMc);
         MovieClipUtil.playMc(this.sceneMc,1,this.sceneMc.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(sceneMc);
            NpcDialog.show(400,"小赛尔",[[0,"萨伦！让灵兽们睡着的就是你们吗！"]],["可恶的萨伦帝国！"],[function():void
            {
               NpcDialog.show(13,"阿修",[[1,"哼，是又怎么样。"]],["好嚣张！"],[function():void
               {
                  NpcDialog.show(400,"小赛尔",[[0,"你们到底是用什么方法让灵兽们都睡着的！"]],[" 可怕的力量！"],[function():void
                  {
                     NpcDialog.show(13,"阿修",[[1,"切~为什么要告诉你。"]],["到底说不说！"],[function():void
                     {
                        NpcDialog.show(400,"小赛尔",[[0,"那就别怪我不客气了!"]],["来战！"],[toFight]);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(param1.stepId == 1)
         {
            NpcDialog.show(400,"小赛尔",[[0,"那就别怪我不客气了!"]],["来战！"],[this.toFight]);
         }
         else if(param1.stepId == 2)
         {
            this.initStep3();
         }
         else if(param1.stepId == 3)
         {
            this.initStep4();
         }
      }
      
      private function initStep4() : void
      {
         this.sceneMc = _processor.resLib.getMovieClip("SceneMc_2");
         _map.content.addChild(this.sceneMc);
         MovieClipUtil.playMc(this.sceneMc,1,this.sceneMc.totalFrames,function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"目灵兽好像快醒了。"]],["终于康复了"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"小梦！我们一起去找那只梦神吧！来让灵兽们都苏醒！"]],["梦神！"],[function():void
               {
                  NpcDialog.show(766,"小梦",[[0,"好！（师傅留下的这些石头，到底有多大的潜力呢……）"]],["神秘的石头"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10234_1"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                        QuestManager.completeStep(questID,1);
                     });
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function onSwitch(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
      }
      
      private function initStep3() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10234_0"),function():void
         {
            sceneMc = _processor.resLib.getMovieClip("SceneMc_1");
            _map.content.addChild(sceneMc);
            MovieClipUtil.playMc(sceneMc,1,sceneMc.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(sceneMc);
               NpcDialog.show(13,"阿修",[[1,"这……是什么力量！"]],["奇怪的石头！"],[function():void
               {
                  NpcDialog.show(766,"小梦",[[0,"师傅给的包裹……居然有这种力量！"]],["来自地球的宝物？"],[function():void
                  {
                     NpcDialog.show(769,"梦魇",[[0,"星…………星……魂…………梦……神…………"]],["星魂？"],[function():void
                     {
                        NpcDialog.show(400,"小赛尔",[[0,"不管怎样！现在正是反败为胜的机会！"]],["趁现在！"],[function():void
                        {
                           if(PetInfoManager.getFirstPetInfo().hp == 0)
                           {
                              initStep4();
                           }
                           else
                           {
                              haveFight = 1;
                              FightManager.startFightWithWild(FIGHT_ID2);
                           }
                        }]);
                     }]);
                  }]);
               }]);
            },true);
         });
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         ActorManager.getActor().show();
      }
      
      private function toFight() : void
      {
         if(PetInfoManager.getFirstPetInfo().hp == 0)
         {
            AlertManager.showAlert("首发精灵血量耗尽！请治疗后再打开任务面板继续任务~",this.changeScene);
            return;
         }
         haveFight = 1;
         FightManager.startFightWithWild(this.FIGHT_ID1);
      }
      
      private function changeScene() : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
   }
}
